class ProgressesController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @progress = @task.progresses.build(progress_params)
    if @progress.valid?
      if @task.progresses.first.id.nil?
        @progress.save
        redirect_to task_path(@task), notice: "進捗を登録しました"
      elsif @task.progresses[-2].created_at.strftime('%Y/%m/%d') == Time.now.strftime('%Y/%m/%d')
        @progress = Progress.last
        @progress.update(progress_params)
        redirect_to task_path(@task), notice: "本日の進捗を更新しました"
      elsif @task.progresses.first.created_at.strftime('%Y/%m/%d') < Time.now.strftime('%Y/%m/%d') #@progress.created_at.strftime('%Y/%m/%d')
        @progress.save
        redirect_to task_path(@task), notice: "進捗を登録しました"
      end
    else
      redirect_to task_path(@task), notice: "進捗の登録に失敗しました"
    end
  end

  private
  
  def progress_params
    params.require(:progress).permit(:percent, :item_number)
  end
end