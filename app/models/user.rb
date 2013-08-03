class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :username, :remember_me,
                  :password_confirmation, :default_stream_id
  attr_accessor :login

  validates :username, uniqueness: true

  before_create :add_default_stream

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
end
