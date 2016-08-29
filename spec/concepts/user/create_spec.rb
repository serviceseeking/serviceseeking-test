require 'rails_helper'

RSpec.describe User::Create do
  it "creates a valid User" do
    res, user = User::Create.run(user: { fullname: "Peter Parker" })

    expect(res).to be true
    expect(user.model.persisted?).to be true
    expect(user.model.fullname).to eq("Peter Parker")
  end  

  it "does not create an invalid User" do
  	res, user = User::Create.run(user: { fullname: "" })

    expect(res).to be false
    expect(user.model.persisted?).to be false
    error_msg = user.contract.errors.full_messages
    expect(error_msg).to include("Fullname can't be blank")    
  end
end
