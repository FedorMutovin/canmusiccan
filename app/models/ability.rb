class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    user_abilities if user
  end

  def user_abilities
    can :read, :all
    can :search_tracks, :all
    can :create, [SpotifyTrack, Follow, Message, Community, Post, Demotrack]
    can :destroy, [SpotifyTrack, Follow, Demotrack], user_id: user.id
    can :update, User, id: user.id
    can %i[update destroy], Community, creator_id: user.id
    can :destroy, Post do |post|
      user.id.eql?(post.postable_id) || Community.find(post.postable_id).creator_id.eql?(user.id)
    end
    can :destroy, ActiveStorage::Attachment do |file|
      user.id.eql?(file.record.id)
    end
  end
end
