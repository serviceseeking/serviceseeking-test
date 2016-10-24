require 'rails_helper'

RSpec.describe Session::SignUp do
	it "valid input" do
		res, op = Session::SignUp.run(user: {username: "trailblazer", password: "password", confirm_password: "password",
			fullname: "trailblazer tutorial"})

		expect(res).to be true
	end
	it "invalid" do
		res, op = Session::SignUp.run(user: {username: "", password: "", confirm_password: "",
			fullname: ""})

		expect(res).to be false
		expect(op.contract.errors.to_s).to eq "{:username=>[\"can't be blank\", \"is too short (minimum is 6 characters)\"], :password=>[\"can't be blank\", \"is too short (minimum is 6 characters)\"], :confirm_password=>[\"can't be blank\"]}"
	end
end

RSpec.describe Session::SignIn do
	it "valid credentials" do
		sign_in_op = Session::SignUp.(user: {username: "trailbazer", password: "password", confirm_password: "password"})

		res, op = Session::SignIn.run(session: {username: "trailblazer", password: "password"})

		expect(op.model).to eq sign_in_op.model
	end

	it "invalid credentials" do
		sign_in_op = Session::SignUp.(user: {username: "trailbazer", password: "password", confirm_password: "password"})

		res, op = Session::SignIn.run(session: {username: "trailblazer", password: "drowssap"})

		expect(res).to eq false
	end

	it "username and password is blank" do
		res, op = Session::SignIn.run(session: {username: "", password: ""})

		expect(op.model).to be nil
		expect(op.contract.errors.to_s).to eq "{:username=>[\"can't be blank\"], :password=>[\"can't be blank\"]}"
	end
end