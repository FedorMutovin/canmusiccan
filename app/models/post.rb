class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true, touch: true
  validates :title, :body, presence: true
end
