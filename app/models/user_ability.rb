class UserAbility
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all
    can :read, [Trainer]
    can :create, []
    if user
      can :read, :all
      can :create, [UserWeight]
      unless user.user_admins_count.zero?
        can :manage, :all
      end
    end
  end
end
