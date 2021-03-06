class User < ApplicationRecord
  include Postable

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :omniauthable,
         omniauth_providers: %i[spotify facebook]

  has_one_attached :avatar
  has_many :authorizations, dependent: :destroy
  has_many :spotify_tracks, dependent: :destroy
  has_many :demotracks, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id, dependent: :destroy, inverse_of: :sender
  has_many :conversations, foreign_key: :receiver_id, dependent: :destroy, inverse_of: :receiver
  has_many :messages, dependent: :destroy
  has_many :communities, foreign_key: 'creator_id', dependent: :destroy, inverse_of: :creator
  belongs_to :community, optional: true

  acts_as_follower
  acts_as_followable

  def self.find_for_oauth(auth)
    FindForOauth.new(auth).call
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid) if persisted?
  end
end
