require "rails_helper"

RSpec.describe User::Create, type: :operation do
  describe "Creating user" do
    context "when id is not nil" do
      it "finds the user" do
        user = User.create(fullname: "Registered User")
        new_user = User::Create.(
          { user: { id: user.id }}
        ).model
        expect(new_user).to eq(user)
      end
    end

    context "when id is nil" do
      it "creates a new guest user" do
        user = User::Create.({ user: { id: nil }}).model
        expect(user.fullname).to eq("Guest")
      end
    end

  end
end
