class PagesController < ApplicationController
  def index
    @todo = Todo.new
  end
end
