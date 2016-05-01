class TodoList::FormCell < Cell::Concept
  def show
    render
  end

  private

  include ActionView::Helpers::FormHelper

  def prompt
    options[:prompt] || default_prompt
  end

  def default_prompt
    "What would you like to name your list?"
  end

  def action_url
    parent_controller.todo_lists_path
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
