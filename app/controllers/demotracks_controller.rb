class DemotracksController < ApplicationController
  before_action :authenticate_user!
  before_action :demotrack, only: :destroy
  before_action :user, only: :create

  skip_authorization_check

  def create
    authorize! :create, @user.demotracks
    redirect_to @user, alert: "You must add only audio file" unless @user.demotracks.attach(params[:demotrack])
  end

  def destroy
    authorize! :destroy, @demotrack
    @demotrack.purge
  end

  private

  def demotrack
    @demotrack = ActiveStorage::Attachment.find(params[:id])
  end

  def user
    @user = User.find(params[:user_id])
  end
end
