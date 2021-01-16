class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true, touch: true
  validates :body, presence: true

  def time
    created_at.strftime('%d/%m/%y at %l:%M %p')
  end
end
