class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @achievement = {}
  end
end
