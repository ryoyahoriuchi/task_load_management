class MemosController < ApplicationController
  before_action :set_task_item, only: %i[edit update destroy]
  def create
    @task = Task.find(params[:task_id])
    #@task_items = TaskItem.where(task_id: params[:task_id])
    @task_item = TaskItem.find(params[:memo][:task_item_id].to_i)
    @memo = @task_item.memos.build(memo_params)
    respond_to do |format|
      if @memo.save
        #format.html { redirect_to task_path(@task.id)}
        format.js { render :index }
      else
        format.html { redirect_to task_path(@task.id), notice: I18n.t('views.messages.failed_to_save_memo') }
      end
    end
  end

  def edit
    @memo = @task_item.memos.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = I18n.t('views.messages.editing_memo')
      format.js { render :edit }
    end
  end

  def update
    @memo = @task_item.memos.find(params[:id])
    respond_to do |format|
      if @memo.update(memo_params)
        flash.now[:notice] = I18n.t('views.messages.edited_memo')
        format.js { render :index }
      else
        flash.now[:notice] = I18n.t('views.messages.failed_to_edit_memo')
        format.js { render :edit }
      end
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    respond_to do |format|
      flash.now[:notice] = I18n.t('views.messages.deleted_memo')
      format.js { render :index }
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:content, :id, :task_item_id)
  end

  def set_task_item
    memo = Memo.find(params[:id])
    @task = Task.find(params[:task_id])
    @task_item = TaskItem.find(memo.task_item.id)
  end

end
