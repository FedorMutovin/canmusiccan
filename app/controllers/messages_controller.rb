class MessagesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  before_action :conversation, only: %i[index create]
  after_action :publish_message, only: :create

  def index
    @messages = @conversation.messages.order(created_at: :asc)
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
    if params[:conversation_id]
      @conversation ||= Conversation.find(params[:conversation_id])
    else
      conversation = Conversation.between(params[:sender_id], params[:receiver_id])
      @conversation = if conversation.present?
                        conversation.first
                      else
                        Conversation.create(conversation_params)
                      end

    end
    gon.conversation_id = @conversation.id
    gon.user_id = current_user.id if current_user
  end

  def conversation_params
    params.permit(:sender_id, :receiver_id)
  end

  def publish_message
    return if @message.errors.any?

    avatar = url_for(@message.user.avatar) if @message.user.avatar.blob

    ActionCable.server.broadcast(
      "conversation-#{@conversation.id}-messages",
      message: @message,
      user_id: @message.user.id,
      email: @message.user.email,
      avatar: avatar,
      time: @message.time
    )
  end
end
