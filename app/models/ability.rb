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
    can :create, SpotifyTrack
    can :destroy, SpotifyTrack, user_id: user.id
    can :search_tracks, :all
    can :update, User, id: user.id
    can :create, Follow
    can :destroy, Follow, user_id: user.id
    can :create, Message
    can :create, Community
    can :create, Post
    can %i[update destroy], Community, creator_id: user.id
    can :destroy, Post do
      user.id.eql?(postable_id) || Community.find(postable_id).creator_id.eql?(user.id)
    end
  end
end
