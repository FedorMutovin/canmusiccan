class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: %i[create destroy]
  authorize_resource

  def create
    current_user.follow(@user)
  end

  def destroy
    current_user.stop_following(@user)
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end
end
