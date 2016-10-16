require 'rails_helper'

RSpec.describe User::Create do
  it "successfully creates a user" do
    expect{
      User::Create.(user: {fullname: "Test"})
    }.to change{User.count}.by(1)
  end
end


