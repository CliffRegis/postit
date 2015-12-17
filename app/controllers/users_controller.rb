class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome you successfully signed up"
      redirect_to root_path
    else
      flash[:notice] = "You weren't able to sign up"
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "You editted your profile"
      redirect_to user_path(@user)
    else
      flash[:notice] = "Something went wrong"
      render 'edit'
    end
  end

  
  private
  
  def user_params
    params.require(:user).permit(:username, :password_confirmation, :password)
  end

  def set_user
    @user = User.find_by slug: params[:id]
  end

end