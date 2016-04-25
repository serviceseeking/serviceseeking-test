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
      "Create a new todo on #{todo_list.name}"
    else
      "What would you like to do?"
    end
  end

  def todo_list
    TodoList.where(id: params[:todo_list_id]).first
  end

  def todo_list_input
    hidden_field(:todo, :todo_list_id, :value => params[:todo_list_id]) if todo_list.present?
  end

  def title_error
    options[:errors].messages[:title].first if options[:errors].present?
  end

  def action_url
    if todo_list.present?
      parent_controller.todo_list_todos_path
    else
      parent_controller.todos_path
    end 
  end

end
