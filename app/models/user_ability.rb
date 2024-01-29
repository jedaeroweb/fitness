class UserAbility
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all
    can :read, [Trainer]
    can :create, []
    if user
      can :read, :all
      can :create, [Enroll,Rent, UserBranch, UserWeight]
    end
  end
end
