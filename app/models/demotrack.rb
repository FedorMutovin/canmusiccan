class Demotrack < ApplicationRecord
  include PublicActivity::Model
  tracked only: :create, owner: ->(controller, _model) { controller && controller.current_user }

  belongs_to :user, touch: true
  has_one_attached :audio
  validates :audio, blob: { content_type: :audio, size_range: 0..5.megabytes }
end
