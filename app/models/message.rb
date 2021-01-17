class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, :conversation_id, :user_id, presence: true
  scope :unread, ->(current_user) { where('user_id != ? AND read = ?', current_user.id, false) }

  def self.read(current_user)
    unread(current_user).update_all(read: true)
  end
end
