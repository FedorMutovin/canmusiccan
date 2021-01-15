class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :resource, only: %i[create destroy]
  authorize_resource

  def create
    current_user.follow(@resource)
  end

  def destroy
    current_user.stop_following(@resource)
  end

  private

  def resource
    @klass = [Community, User].find { |klass| params["#{klass.name.underscore}_id"] }
    @resource = @klass.find(params["#{@klass.name.underscore}_id"])
  end
end
