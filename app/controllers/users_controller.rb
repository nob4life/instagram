class UsersController < ApplicationController
  before_action  only: [:index, :following, :followers]
  before_action :set_user, only: %i[ update add_photo ]
  
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        
        format.html { redirect_to root_url(@user), notice: "Photo was successfully updated." }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def add_photo
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow', status: :unprocessable_entity
  end
  
  def followers 
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow', status: :unprocessable_entity
  end


  private

  def set_user
    @user = current_user
  end


  def user_params
    params.require(:user).permit(:photo)
  end
end