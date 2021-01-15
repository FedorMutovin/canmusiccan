class Community < ApplicationRecord
  has_many :users, dependent: :destroy
  belongs_to :creator, class_name: 'User'

  has_one_attached :avatar
end
