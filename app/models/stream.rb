class Stream < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user
  has_many :posts

  validates :name, :user_id, presence: true
  validates :user_id, numericality: true
end
