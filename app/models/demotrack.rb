class Demotrack < ApplicationRecord
  belongs_to :user
  has_one_attached :audio
  validates :audio, blob: { content_type: :audio, size_range: 0..5.megabytes }
end
