require 'rails_helper'

RSpec.describe Session do
  before(:each) do
    @password_hldr = "12345!Aa"
    @user = Session::Create.({user: {username: 'TestUser', password: @password_hldr, confirm_password: @password_hldr,
                                     fullname: 'Test User'}}).model
    @todo_list = TodoList::Create.({todo_list: {name: 'this is a test', user_id: @user.id}}).model
  end

  describe "Login" do
    it "should not allow a blank username or password" do
      expect{ Session::Login.({ user: { username: '',
                                        password: '' }}).errors.messages[:username] }.to raise_error(/can't be blank/)
    end

    it "should not authenticate a user with invalid creadential" do
      expect{Session::Login.({ user: { username: @user.username,
                                       password: @password_hldr  + "1"}})}.to raise_error(/Invalid credentials/)
    end

    it "should authenticate a user with valid credentials" do
      expect(Session::Login.({ user: { username: @user.username,
                                       password: @password_hldr}}).model.id).to equal(@user.id)
    end
  end

  describe "Create" do
    it "should create a new user" do
      expect{Session::Create.({user: {
        username: "TestUser1", password: "12345!Hg99", confirm_password: "12345!Hg99",
        fullname: "Test User 1"}})}.to change(User, :count).by(1)
    end

    it "should validate password and confirmation are the same" do
      expect{Session::Create.({user: {
        username: "TestUser1", password: "12345!Hg99", confirm_password: "23345!Hg99",
        fullname: "Test User 1"}})}.to raise_error(Trailblazer::Operation::InvalidContract)
    end

    it "should validate for a valid password" do
      expect{Session::Create.({user: {
        fullname: "Test User 1"}})}.to raise_error(/Minimum 8 characters at/)
    end

    it "should not allow duplicate usernames" do
      expect{Session::Create.({user: {
        username: "TestUser", password: "12345!Hg99", confirm_password: "12345!Hg99",
        fullname: "Test User 1"}})}.to raise_error(/is not avaliable/)
    end
  end

  describe "delete" do

    it "should delete the user and the Todo List" do
      @todo_list_count = TodoList.count
      @user_count = User.count

      Session::Delete.({ id: @user.id })

      expect(TodoList.count).to equal( @todo_list_count - 1)
      expect(User.count).to equal( @user_count - 1)
    end
  end

  describe "Find" do
    it "should return a user" do
      expect(Session::Find.({id: @user.id}).model.username).equal?(@user.username)
    end
  end

  describe "CreateGuestUser" do
    it "should create a new guest user" do
      @guest_user_count = User.where("username LIKE 'guest%'").count
      @guest_user = Session::CreateGuestUser.({}) 

      expect(User.where("username LIKE 'guest%'").count).to equal(@guest_user_count + 1)
    end
  end
end
