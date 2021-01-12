class MessagesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  before_action :conversation, only: %i[index create]

  def index
    @messages = @conversation.messages
    @messages.read(current_user)
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.body = params[:body] if params[:body]
    @message.user = current_user
    @message.save
  end

  private

  def message_params
    params.permit(:body)
  end

  def conversation
    return @conversation ||= Conversation.find(params[:conversation_id]) if params[:conversation_id]

    conversation = Conversation.between(params[:sender_id], params[:receiver_id])
    @conversation = if conversation.present?
                      conversation.first
                    else
                      Conversation.create(conversation_params)
                    end
  end

  def conversation_params
    params.permit(:sender_id, :receiver_id)
  end
end
