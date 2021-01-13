class MessagesChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "conversation-#{data['conversation_id']}-messages"
  end
end
