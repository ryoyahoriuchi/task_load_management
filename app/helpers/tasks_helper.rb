module TasksHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create'
      suggestion_tasks_path
    elsif action_name == 'edit' || action_name == 'update'
      suggestion_task_path
    end
  end

  def suggestion_new_or_edit
    if @task.id?
      task_path
    else
      tasks_path
    end
  end

  def suggestion_form_method
    @task.id ? 'patch' : 'post'
  end
end
