class Post < ApplicationRecord
  include  PublicActivity::Model

  belongs_to :postable, polymorphic: true, touch: true
  validates :body, presence: true
  scope :sorted, -> { order(created_at: :desc) }
end
