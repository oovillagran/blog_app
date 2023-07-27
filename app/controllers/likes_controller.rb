class LikesController < ApplicationController
  def create
    @post = Post.fin(params[:post_id])
    @like = @post.likes.build(author: current_user)

    if @like.save
      redirect_to user_post_path(current_user, @post), notice: 'Liked the post!'
    else
      redirect_to user_post_path(current_user, @post), alert: 'Failed to like the post.'
    end
  end
end
