class Session::Cell::Auth  < ::Cell::Concept
  inherit_views Session::Cell

  include ActionView::Helpers::FormHelper
  include ActionView::RecordIdentifier
  include SimpleForm::ActionViewExtensions::FormHelper

  def sign_up
    render :sign_up
  end

  def sign_in
    render :sign_in
  end
end
