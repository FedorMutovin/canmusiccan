class ConversationsController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check

  def index
    @conversations = Conversation.previously_created(current_user)
  end

  private

  def conversation_params
    params.permit(:sender_id, :receiver_id)
  end
end
