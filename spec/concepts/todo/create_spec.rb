require 'rails_helper'

RSpec.describe Todo::Create do
  
  subject { described_class }

  describe "Process" do 
  	context "with valid params" do
  		let(:params) { { todo: { title: "Todo title"  } } }

  		it "persists the params" do
  			res, op = subject.run(params)

  			expect(op.model.persisted?).to be_truthy
  			expect(res).to be_truthy
  		end
  	end

  	context "with invalid params" do
  		let(:params) { { todo: { title: "" } } }

  		it "does not persist the params" do
  			res, op = subject.run(params)

  			expect(op.model.persisted?).to be_falsy
  			expect(res).to be_falsy
  		end
  	end
  end
end