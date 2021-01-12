class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :messages, dependent: :destroy

  validates :sender_id, uniqueness: { scope: :receiver_id }

  scope :previously_created, lambda { |current_user|
                               where('sender_id = ? OR receiver_id = ?', current_user.id, current_user.id)
                             }
  scope :between, lambda { |sender_id, receiver_id|
    where('(conversations.sender_id = ? AND conversations.receiver_id = ?)
          OR (conversations.receiver_id = ? AND conversations.sender_id = ?)',
          sender_id, receiver_id, sender_id, receiver_id)
  }

  DEFAULT_UNREAD_MESSAGES_COUNT = 0

  def self.unread_messages_count(current_user)
    count = DEFAULT_UNREAD_MESSAGES_COUNT
    previously_created(current_user).each { |conversation| count += conversation.unread_message_count(current_user) }
    count
  end

  def recipient(current_user)
    sender_id.eql?(current_user.id) ? receiver : sender
  end

  def unread_message_count(current_user)
    messages.unread(current_user).count
  end
end
