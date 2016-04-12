require 'rails_helper'

RSpec.describe Todo::Create do
	# context "when a title is given" do
  		it "creates a new title" do
    		todo = Todo::Create.(todo: {title: "Sample title"}).model
    		expect(todo).to be_persisted
  		end
    # end
    # context "when a title is not given" do
  		# it "will not create a new title" do
    # 		todo = Todo::Create.run(todo: {title: nil}).model
    # 		expect(todo).to_not be_persisted
  		# end
    # end
end


