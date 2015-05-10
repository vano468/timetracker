class Department < ActiveRecord::Base
  include Hierarchy

  belongs_to :parent,  class_name: 'Department', foreign_key: 'parent_id'
  belongs_to :boss,    class_name: 'User',       foreign_key: 'boss_id'

  has_many :employees, class_name: 'User',       foreign_key: 'department_id'
  has_many :children,  class_name: 'Department', foreign_key: 'parent_id'

  validates :title, presence: true
  validate :should_be_reachable_from_root

  scope :top_level, -> { where parent_id: nil }

private

  def should_be_reachable_from_root
    errors.add(:parent_id, 'should be reachable from root') unless Validation::ReachRootFromDepartment.new(self).reach_root
  end
end