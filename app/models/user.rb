class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  belongs_to :department
  belongs_to :boss_of, class_name: 'Department', foreign_key: 'boss_id'
end