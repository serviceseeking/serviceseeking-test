require 'rails_helper'

RSpec.describe Todo::Create do

  before { @todo = Todo.new }

  it "should be an instance of Todo" do
    expect(@todo).to be_an_instance_of Todo
  end

  context "with valid params" do
  
    let(:params) { { "todo" => {"title" => "valid"} } }
       
      

       it "will set flash[:notice]" do
         expect(:notice).to be_present
       end
     
  end

  context "when invalid" do
     let(:params) { { "todo" => {"title" => ""} } } 

     res, op = subject.run(params)

     it "will set flash alert" do
       expect(:alert).to be_present
     end

  #   it "will render new" do
  #     expect(response).to render_template("new")
  #   end

  end


end
  