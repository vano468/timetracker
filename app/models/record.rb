class Record < ActiveRecord::Base
  belongs_to :user

  after_save :send_notifications
private
  def send_notifications
    puts "Let's send some notifications for those emails: #{emails}"
  end
end
