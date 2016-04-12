require 'rails_helper'

RSpec.describe User::Create do
	#context "when a todo list is not found" do
  	it "creates a new user" do
    	user = User::Create.(todo: {title: "Sample title"}).model
    	expect(user.fullname).to eq("Guest")
  	end
  #end
end