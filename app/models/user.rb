class User < ActiveRecord::Base
  include RoleModel
  roles_attribute :roles_mask
  roles :bookkeeper, :admin

  belongs_to :department
  has_one :boss_of, class_name: 'Department', foreign_key: 'boss_id'

  has_many :records
  has_many :comments

  scope :without_department, -> { where department: nil }
  scope :ordered, -> { order :id }

  def self.by_department(department)
    where department: department
  end

  devise :database_authenticatable, :rememberable, :trackable, :validatable
end