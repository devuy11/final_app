class StaticPagesController < ApplicationController
  def home
    unless current_user.nil? 
      @feed_items = current_user.feed_var.paginate(page: params[:page])
      @micropost = current_user.microposts.build if signed_in?
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def signup
  end
end
