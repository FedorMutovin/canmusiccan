class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: :show
  authorize_resource

  def show; end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
