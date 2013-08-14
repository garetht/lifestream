class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id, :friend_status

  belongs_to :user
  belongs_to :friend, class_name: "User", primary_key: :id

  validates :friend_id, :user_id, presence: true
  validates :friend_id, :user_id, numericality: true
  validates :friend_status, inclusion: {:in => ["pending", "requested", "confirmed"]}

end
