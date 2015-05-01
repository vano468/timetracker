class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :record

  validates :message, presence: true
end