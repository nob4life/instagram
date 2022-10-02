class UsersController < ApplicationController
  before_action :set_user, only: %i[ update ]
  before_action  only: [:index, :following, :followers]
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    #binding.pry
    render 'show_follow', status: :unprocessable_entity
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    #@users = @user.followers.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
      else
        raise "exit"
        #format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def add_photo
    @user = current_user
  end

  private

  def set_user
    @user = current_user
  end


  def user_params
    params.require(:user).permit(:photo)
  end
end