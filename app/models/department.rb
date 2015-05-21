class Department < ActiveRecord::Base
  include Hierarchy

  belongs_to :parent,  class_name: 'Department', foreign_key: 'parent_id'
  belongs_to :boss,    class_name: 'User',       foreign_key: 'boss_id'

  has_many :employees, class_name: 'User',       foreign_key: 'department_id'
  has_many :children,  class_name: 'Department', foreign_key: 'parent_id'

  validates :title, presence: true
  validates_with ReachRootValidator

  scope :top_level, -> { where parent_id: nil }
end