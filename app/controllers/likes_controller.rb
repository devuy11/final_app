class LikesController < ApplicationController
  before_action :signed_in_user

  def create
    #debugger
    @post = Micropost.find(params[:like][:micropost_id])
    is_profile = params[:is_profile].to_i

    if is_profile == 1
      @part = "mylike_item"
    else
      @part = "feed_item"
    end
    current_user.likepost(@post)
    respond_to do |format|
      format.html { 
        user = User.find(@post.user_id)
        redirect_to @user 
      }
      format.js
    end
  end

  def destroy
    @post = Micropost.find(Like.find(params[:id]).micropost_id)
    is_profile = params[:is_profile].to_i

    if is_profile == 1
      @part = "mylike_item"
    else
      @part = "feed_item"
    end
    
    current_user.unlikepost(@post)
    respond_to do |format|
      format.html { 
        user = User.find(@post.user_id)
        redirect_to @user 
      }
      format.js
    end
  end
end