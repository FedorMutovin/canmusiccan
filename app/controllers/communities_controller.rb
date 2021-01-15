class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :community, only: :show
  authorize_resource

  def index
    @communities = Community.all
  end

  def show; end

  private

  def community
    @community ||= Community.find(params[:id])
  end
end
