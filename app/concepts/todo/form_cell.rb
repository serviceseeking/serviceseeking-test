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
    TodoList.find(params[:todo_list_id]) rescue nil
  end

  def action_url
    return parent_controller.todo_list_todos_path if todo_list.present?
    parent_controller.todos_path
  end

  def back_url
    return parent_controller.todo_list_path(todo_list) if todo_list.present?
  end

  def errors
    return "" unless options[:errors].present?
    content_tag :div, nil,  class: 'alert alert-danger', role: 'alert' do
      options[:errors].collect do |msg|
        content_tag :p, msg
      end.join.html_safe
    end
  end
end
