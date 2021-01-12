class ConversationsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def index
    @conversations = Conversation.previously_created(current_user)
  end
end
