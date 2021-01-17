class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check

  def index
    @activities = PublicActivity::Activity.order(created_at: :desc).where(owner_id: current_user.all_following)
  end
end
