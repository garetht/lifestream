class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id

  def trace_full_route
    start = self
    @route = [start]
    while start.parent_id
      parent = Category.find(start.parent_id)
      @route << parent
      start = parent
    end
    @route
  end

  def trace_id_route
    startid, parentid = self.id, self.parent_id
    @route =  [startid, parentid]
    while parentid
      parentid = Category.find(parentid).parent_id
      @route << parentid
      startid = parentid
    end
    @route[0...-1]
  end
end
