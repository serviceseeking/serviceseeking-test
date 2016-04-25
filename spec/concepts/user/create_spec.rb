require 'rails_helper'
RSpec.describe User::Create do

  it "is valid" do
    @user = User.create(fullname: "Guest")
    expect(@user.fullname).not_to be_empty
  end

  it "is invalid" do
    @user = User.create(fullname: nil)
    expect(@user.fullname).to be_nil
  end
end
