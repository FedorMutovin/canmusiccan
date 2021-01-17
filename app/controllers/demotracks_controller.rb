class DemotracksController < ApplicationController
  before_action :authenticate_user!
  before_action :demotrack, only: :destroy
  before_action :user, only: :create

  authorize_resource

  def create
    @demotrack = @user.demotracks.new
    @demotrack.audio.attach(params[:demotrack])
    redirect_to @user, alert: t('demotracks.format_error') unless @demotrack.save
  end

  def destroy
    @demotrack.destroy
  end

  private

  def demotrack
    @demotrack ||= Demotrack.find(params[:id])
  end

  def user
    @user ||= User.find(params[:user_id])
  end
end
