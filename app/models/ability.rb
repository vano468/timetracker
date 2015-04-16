class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Record
    return if user.new_record?
    can [:create, :requested], Record
    can [:update, :destroy], Record, user_id: user.id
    can [:bookkeeping, :bookkeeper_approve], Record if user.has_role? :bookkeeper
    can :pending, Record if user.boss_of.present?
    can [:boss_approve, :boss_disapprove], Record, Record do |record|
      record.user.department == user.boss_of
    end
  end
end
