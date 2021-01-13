class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: :show
  authorize_resource

  def show
    @unread_messages_count = Conversation.unread_messages_count(current_user)
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
