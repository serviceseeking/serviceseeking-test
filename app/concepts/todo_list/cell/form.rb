class TodoList::Cell::Form < ::Cell::Concept
  inherit_views TodoList::Cell
  include ActionView::Helpers::FormHelper
  include ActionView::RecordIdentifier
  include SimpleForm::ActionViewExtensions::FormHelper
  # include SessionHelper

  def new
    render :form
  end

  def edit
    render :form
  end
end
