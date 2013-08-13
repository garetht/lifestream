class Comment < ActiveRecord::Base
  attr_accessible :parent_id, :post_id, :text, :user_id

  belongs_to :user
  belongs_to :post

  has_many :children, class_name: "Comment", foreign_key: :parent_id
  has_one :parent, class_name: "Comment", primary_key: :parent_id, 
          foreign_key: :id


  def self.children_hash(post_id)
    comments = Comment.where('post_id = ?', post_id)
    hash = Hash.new(Array.new)
    comments.each do |comment|
      hash[comment.parent_id] += [comment]
    end 
    hash
  end

end
