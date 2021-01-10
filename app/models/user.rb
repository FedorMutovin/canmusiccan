class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :omniauthable,
         omniauth_providers: %i[spotify facebook]

  has_one_attached :avatar
  has_many_attached :demotracks
  has_many :authorizations, dependent: :destroy
  has_many :spotify_tracks, dependent: :destroy

  validates :demotracks, blob: { content_type: :audio, size_range: 0..5.megabytes }

  acts_as_follower
  acts_as_followable
  acts_as_messageable

  def self.find_for_oauth(auth)
    FindForOauth.new(auth).call
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid) if persisted?
  end
end
