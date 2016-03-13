class Todo::FormCell < Cell::Concept

  def show
    render
  end

  private

  include ActionView::Helpers::FormHelper

  def prompt
    options[:prompt] || default_prompt
  end

  def default_prompt
    if todo_list.present?
      "New todo on #{todo_list.name}"
    else
      "What would you like to do?"
    end
  end

  def todo_list
    TodoList.where(id: params[:todo_list_id]).first
  end

  def action_url
    parent_controller.todos_path
  end

end
