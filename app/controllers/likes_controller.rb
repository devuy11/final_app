class LikesController < ApplicationController
  before_action :signed_in_user

  def create
    @post = Micropost.find(params[:like][:micropost_id])
    current_user.likepost(@post)
    user = User.find(@post.user_id)
    redirect_to user
    
  end

  def destroy
    @post = Micropost.find(Like.find(params[:id]).micropost_id)
    current_user.unlikepost(@post)
    user = User.find(@post.user_id)
    redirect_to user
  end
end