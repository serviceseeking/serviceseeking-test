require 'rails_helper'

RSpec.describe User::Find do
  it "finds a user guest" do
    user = User::Find.(todo: {title: "Testing helps!"}).model
    expect(user.fullname).to eq("Guest")
  end
end
