class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    if ( current_user.id != @user.id ) && ( current_user.admin? == false )
      redirect_to tasks_path, notice: "他のユーザーページにはアクセスできません"
    end
    @achievement = {}
  end
end
