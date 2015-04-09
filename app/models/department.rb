class Department < ActiveRecord::Base
  has_one :boss, class_name: 'User', foreign_key: 'id'
  has_many :employees, class_name: 'User', foreign_key: 'department_id'
  belongs_to :parent, class_name: 'Department', foreign_key: 'parent_id'
  has_many :children, class_name: 'Department', foreign_key: 'parent_id'
end
