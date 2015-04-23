module Department::Hierarchy
  def hierarchy
    hierarchy = []
    current   = self
    hierarchy << current
    while current = current.parent
      hierarchy << current
    end
    hierarchy.reverse!
  end

  def hierarchy_title
    "#{'―' * (hierarchy.count - 1)} #{title}"
  end

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def hierarchy_tree
      result = []
      top_level.order(:id).each do |d|
        add_children_of_parent d, result
      end
      result
    end

    def add_children_of_parent(parent, result)
      result << parent
      return if parent.children.blank?
      parent.children.each do |child|
        add_children_of_parent(child, result)
      end
    end
  end

end