class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :community, only: %i[show new edit update destroy]
  authorize_resource

  def index
    @communities = Community.all
  end

  def show; end

  def new; end

  def create
    @community = Community.new(community_params.merge(creator: current_user))

    if @community.save
      redirect_to @community, notice: t('.community_created_info')
    else
      render :new
    end
  end

  def edit; end

  def update
    @community.update(community_params)

    if @community.save
      redirect_to @community, notice: t('.community_updated_info')
    else
      render :edit
    end
  end

  def destroy
    if @community.destroy
      redirect_to communities_path, notice: t('.community_deleted_info')
    else
      render communities_path
    end
  end

  private

  def community_params
    params.require(:community).permit(:name, :description, :creator, :avatar)
  end

  def community
    @community ||= params[:id] ? Community.with_attached_avatar.find(params[:id]) : Community.new
  end
end
