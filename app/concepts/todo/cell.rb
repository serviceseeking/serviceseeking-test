class Todo::Cell < ::Cell::Concept
  include ActionView::Helpers::FormHelper
  include ActionView::RecordIdentifier
  include SimpleForm::ActionViewExtensions::FormHelper


  def show
    render
  end

  def edit
    render :form
  end

  private

  def prompt
    options[:prompt] || default_prompt
  end

  def default_prompt
    if todo_list.present?
      "Create a new todo on #{todo_list.name}"
    else
      "What would you like to do?"
    end
  end

  def todo_list
    TodoList.where(id: params[:todo_list_id]).first
  end

  def action_url
    if params[:todo_list_id].nil? then
      parent_controller.todos_path
    else
      todo_list_todos_path
    end
  end

end
