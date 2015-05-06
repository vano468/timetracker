class User < ActiveRecord::Base
  include Wisper::Publisher
  include RoleModel

  roles_attribute :roles_mask
  roles :bookkeeper, :admin

  belongs_to :department
  has_one :boss_of, class_name: 'Department', foreign_key: 'boss_id'

  has_many :records
  has_many :comments

  validates :email, :first_name, :last_name, presence: true

  scope :without_department, -> { where department: nil }
  scope :ordered, -> { order :id }

  after_create do
    broadcast :after_create_user, self
  end

  def self.by_department(department)
    where department: department
  end

  devise :database_authenticatable, :rememberable, :trackable, :validatable, :recoverable
end