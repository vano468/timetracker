class User < ActiveRecord::Base
  belongs_to :department
  belongs_to :boss_of, class_name: 'Department', foreign_key: 'boss_id'
end
