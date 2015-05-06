class UserDecorator < Draper::Decorator
  delegate_all

  def role
    role = 'employee'
    role = 'bookkeeper' if object.has_role? :bookkeeper
    role = 'boss'       if is_boss?
    role = 'admin'      if object.has_role? :admin
    role
  end

private

  def is_boss?
    if object.department
      object == object.department.boss
    else
      false
    end
  end
end