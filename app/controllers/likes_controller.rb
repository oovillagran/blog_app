class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    existing_like = @post.likes.find_by(author: current_user)

    if existing_like
      flash[:alert] = "You have already liked this post."
      redirect_to user_post_path(@post.author, @post)
    else
      @like = current_user.likes.new(post: @post)
      if @like.save
        flash[:notice] = "You liked the post successfully."
        redirect_to user_post_path(@post.author, @post)
      else
        flash[:alert] = "Something went wrong. Please try again."
        redirect_to user_post_path(@post.author, @post)
      end
    end
  end
end
