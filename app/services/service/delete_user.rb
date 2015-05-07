module Service
  class DeleteUser
    def initialize(user)
      @user = user
    end

    def delete
      boss_of = Department.where(boss_id: @user).take
      boss_of.update_attribute :boss_id, nil if boss_of.present?
      @user.records.each do |r|
        r.destroy
      end
      @user.comments.each do |c|
        c.destroy
      end
      @user.destroy
    end
  end
end
