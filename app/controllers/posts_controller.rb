class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :resource, only: :create
  before_action :post, only: :destroy
  authorize_resource

  def create
    @post = @resource.posts.create(post_params)
  end

  def destroy
    @post.destroy
  end

  private

  def resource
    @klass = [Community, User].find { |klass| params["#{klass.name.underscore}_id"] }
    @resource = @klass.find(params["#{@klass.name.underscore}_id"])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def post
    @post ||= Post.find(params[:id])
  end
end
