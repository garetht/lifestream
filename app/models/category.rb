class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id, :user_id

  # has_many :children, class_name: "Category", foreign_key: 
  has_many :children, class_name: "Category", foreign_key: :parent_id
  has_one :parent, class_name: "Category", primary_key: :parent_id, 
          foreign_key: :id
  
  belongs_to :user

  has_many :post_categories
  has_many :posts, through: :post_categories

  def trace_full_path
    start = self
    @route = [start]
    while start.parent
      @route << start.parent
      start = start.parent
    end
    @route
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
