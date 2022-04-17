class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    if ( current_user.id != @user.id ) && ( current_user.admin? == false )
      redirect_to tasks_path, notice: I18n.t('views.messages.unable_to_access_other_user_pages')
    end
    
    not_started = 0
    underway = 0
    completed = 0
    @user.tasks.each do |task|
      case task.status
      when "not_started"
        not_started += 1
      when "underway"
        underway += 1
      when "completed"
        completed += 1
      end
    end
    @achievement = {"未着手" => not_started, "着手中" => underway, "完了" => completed}
  end
end