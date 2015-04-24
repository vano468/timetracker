class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    if @user
      employee
      bookkeeper
      boss
    end
  end

  def employee
    can [:read, :create, :requested, :sickness, :day_off, :vacation], Record
    can [:update, :destroy], Record, user_id: @user.id
    can [:create, :update, :destroy], Worktime, user_id: @user.id
  end

  def bookkeeper
    can [:bookkeeping, :bookkeeper_approve], Record if @user.has_role? :bookkeeper
  end

  def boss
    can [:pending], Record if @user.boss_of.present?
    can [:boss_approve, :boss_disapprove], Record, Record do |record|
      record.user.department == @user.boss_of
    end
  end
end