class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def new
    @user = User.new
  end

  def show
    @user=User.where(id: params[:id])
    if @user.empty?
      @user = nil
    else
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])
    end
    #@user = User.find(params[:id])
    #debugger
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
    	flash[:success] = "Welcome to the Sample App!"
    	redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def index
    @users = User.all.paginate(page: params[:page]).order('name ASC')
    #debugger
    #1
    #@users = User.paginate(page: params[:page])
  end

  def edit
    #@user = User.find(params[:id])
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'  
  end


  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user==(@user)
          redirect_to @user 
          flash[:error] = "You cannot Edit some other people data"
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    #def current_user?
      #unless current_user.nil?
      # current_user == @user
     # end
    #end


end
