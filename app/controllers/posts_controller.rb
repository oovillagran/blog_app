class PostsController < ApplicationController
  before_action :find_user

  def index
    @posts = Post.all
    @comments = Comment.all
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

  def new
    @post = @user.posts.new
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
