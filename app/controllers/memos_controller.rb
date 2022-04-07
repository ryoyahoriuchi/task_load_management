class MemosController < ApplicationController
  def create
    #@task = Task.find(params[:task_id])
    #@task_items = TaskItem.where(task_id: params[:task_id])
    @task_item = TaskItem.find(params[:memo][:task_item_id].to_i)
    @memo = @task_item.memos.build(memo_params)

    respond_to do |format|
      if @memo.save
        #format.html { redirect_to task_path(@task.id)}
        format.js { render :index }
      else
        format.html { redirect_to task_path(@task.id), notice: '保存できませんでした' }
      end
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:content, :id, :task_item_id )
  end

end
