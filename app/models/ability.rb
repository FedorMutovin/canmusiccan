class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    user_abilities if user
  end

  def user_abilities
    can :read, :all
    can :destroy, ActiveStorage::Attachment do |file|
      user.id.eql?(file.record.id)
    end
    can :create, ActiveStorage::Attached::Many, record: user
  end
end
