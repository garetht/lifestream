class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]
  attr_accessible :email, :password, :username, :remember_me,
                  :password_confirmation, :default_stream_id,
                  :login, :friend_ids
  attr_accessor :login

  has_many :streams, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  has_many :categories, dependent: :destroy

  has_many :comments, dependent: :destroy

  validates :username, uniqueness: true

  before_create :add_default_stream
  after_create :customize_default_stream

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", {:value => login}]).first
    else
      where(conditions).first
    end
  end

  def add_default_stream
    new_stream = Stream.create
    self.default_stream_id = new_stream.id
  end

  def customize_default_stream
    lastid = User.last.id
    Stream.last.update_attributes(user_id: lastid, name: "User #{lastid}'s Stream")
  end

  def posts
    Post.where("stream_id IN (?)", streams.pluck(:id))
  end

  def friend_query(status)
    User.find_by_sql(<<-sql)
      SELECT users.*
      FROM "users" INNER JOIN "friendships"
      ON "friendships"."friend_id" = "users"."id"
      WHERE friend_status = #{status}
      AND user_id = #{id}
    sql
  end

  def confirmed_friends
    friend_query("'confirmed'")
  end

  def pending_friends
    friend_query("'pending'")
  end

  def requested_friends
    friend_query("'requested'")
  end

  def all_posts
    accessible_posts = <<-sql
      SELECT posts.*
      FROM posts
      WHERE stream_id IN 
        (   SELECT streams.id
            FROM streams
            WHERE streams.user_id = ? )
      OR (stream_id IN
        (   SELECT streams.id
            FROM users INNER JOIN friendships
            ON users.id = friendships.user_id
            INNER JOIN streams
            ON streams.user_id = friendships.friend_id
            WHERE users.id = ?
          ) AND "posts"."public_type" = "public")
      ORDER BY created_at DESC
    sql

    Post.find_by_sql [accessible_posts, id, id]
  end
end
