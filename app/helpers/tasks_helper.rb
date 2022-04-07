module TasksHelper
  def choose_new_or_edit
    if action_name == "new" || action_name == "create"
      suggestion_tasks_path
    elsif action_name == "edit" || action_name == "update"
      #task_path(@task.id)
      suggestion_task_path
    end
    # unless @task.id?
    #   suggestion_tasks_path
    # else
    #   suggestion_tasks_path(@task.id)
    # end
  end

  def suggestion_new_or_edit
    unless @task.id?
      tasks_path
    else
      task_path
    end
  end

  def suggestion_form_method
    @task.id ? "patch" : "post"
  end
end
