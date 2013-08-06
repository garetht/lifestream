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

  has_many :streams
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

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

  def confirmed_friends
    User.find_by_sql(<<-sql)
    SELECT users.*
    FROM "users" INNER JOIN "friendships"
    ON "friendships"."friend_id" = "users"."id"
    WHERE friend_status = 'confirmed'
    AND user_id = #{id}
    sql
  end

  def pending_friends
    User.find_by_sql(<<-sql)
    SELECT users.*
    FROM "users" INNER JOIN "friendships"
    ON "friendships"."friend_id" = "users"."id"
    WHERE friend_status = 'pending'
    AND user_id = #{id}
    sql
  end

  def requested_friends
    query = <<-sql
    SELECT users.*
    FROM "users" INNER JOIN "friendships"
    ON "friendships"."friend_id" = "users"."id"
    WHERE friend_status = 'requested'
    AND user_id = #{id}
    sql
    User.find_by_sql(query)
  end
end
