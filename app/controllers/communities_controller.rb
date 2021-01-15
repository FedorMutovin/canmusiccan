class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def index
    @communities = Community.all
  end
end
