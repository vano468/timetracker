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
end