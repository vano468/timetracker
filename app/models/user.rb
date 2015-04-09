class User < ActiveRecord::Base
  belongs_to :department
  has_one :boss_of, class_name: 'Department', foreign_key: 'boss_id'

  devise :database_authenticatable, :rememberable, :trackable, :validatable
end