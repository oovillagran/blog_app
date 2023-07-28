class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.all
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
  end
end
