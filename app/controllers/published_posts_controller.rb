class PublishedPostsController < ApplicationController
  # GET /posts or /posts.json
  def index
    @posts = admin_user? ? Post.all : Post.published
  end

  # GET /posts/1 or /posts/1.json
  def show
    scope = admin_user? ? Post.all : Post.published
    @post = scope.find(params.expect(:id))
  end
end
