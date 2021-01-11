class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: %i[index show]
  skip_authorization_check
  def index

  end

  def show

  end

  def new

  end

  def create

  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end
end
