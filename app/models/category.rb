class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id, :user_id

  # has_many :children, class_name: "Category", foreign_key: 
  has_many :children, class_name: "Category", foreign_key: :parent_id
  has_one :parent, class_name: "Category", primary_key: :parent_id, 
          foreign_key: :id
  
  belongs_to :user

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :user_id, :name, presence: true
  validates :user_id, numericality: true

  def trace_full_path
    start = self
    @route = [start]
    while start.parent
      @route << start.parent
      start = start.parent
    end
    @route
  end

  def self.children_hash(user_id)
    categories = Category.where('user_id = ?', user_id)
    hash = Hash.new(Array.new)
    categories.each do |category|
      hash[category.parent_id] += [category]
    end 
    hash
  end

  def trace_id_path
    start = self
    @route = [start.id]
    while start.parent
      @route << start.parent.id
      start = start.parent
    end
    @route
  end
end
