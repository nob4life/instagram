class UsersController < ApplicationController

  def index
    @users = User.all
    #binding.pry
  end

  def show
    @user = User.find(params[:id])
  end

end