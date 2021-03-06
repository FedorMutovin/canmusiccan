class Community < ApplicationRecord
  include Postable

  has_many :users, dependent: :destroy
  belongs_to :creator, class_name: 'User'

  has_one_attached :avatar

  validates :name, presence: true

  acts_as_followable
end
