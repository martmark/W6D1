class PolyTreeNode
  attr_reader :parent, :value  
  attr_accessor :children
  
  def initialize(value)
    @value = value
    @parent = nil 
    @children = []
  end

  def parent=(parent)
    if @parent != nil
        self.parent.children.delete(self)
    end

    @parent = parent
    if !parent.nil? 
        parent.children << self unless parent.children.include?(self)
    end
  end 

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    raise "Not a child " if !self.children.include?(child_node)
    child_node.parent=(nil)
  end 

  def dfs(target)
    return self if value == target
    
    self.children.each do |child| 
      search = child.dfs(target)
      return search unless search.nil?
    end 
    nil
  end 


  def bfs(target)
    queue = [self]

    until queue.empty?
      el = queue.shift
     if el.value == target
         return el
     else 
      queue += el.children
     end 
    end 
    nil
  end 
end