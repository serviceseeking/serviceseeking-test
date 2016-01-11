class Todo::FormCell < Cell::Concept

  def show
    render
  end

  private

  include ActionView::Helpers::FormHelper

  def action_url
    parent_controller.todos_path
  end

end
