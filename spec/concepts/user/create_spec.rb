require 'rails_helper'

RSpec.describe User::Create do
  context "valid" do
    it "creates a user" do
      attrs = { fullname: 'Guest' }
      res, op = User::Create.run(user: attrs)
      expect(res).to eq(true)
      expect(op.model).to be_persisted
      expect(op.model.fullname).to eq('Guest')
    end
  end

  context "invalid" do
    it "does not create a user" do
      attrs = { fullname: nil }
      res, op = User::Create.run(user: attrs)
      expect(res).to eq(false)
      expect(op.model).not_to be_persisted

      msg = op.contract.errors.full_messages
      expect(msg).to include("Fullname can't be blank")
    end
  end
end
