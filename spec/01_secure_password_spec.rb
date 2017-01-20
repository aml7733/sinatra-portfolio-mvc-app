require 'spec_helper'

describe 'App' do
  include Rack::Test::Methods

  describe "GET '/'" do
    it "returns a 200 status code" do
      get '/'
      expect(last_response.status).to eq(200)
    end
  end

  describe "Signing Up" do

    it "displays Sign Up Page" do
      get '/coaches/signup'
      expect(last_response.body).to include('Name:')
      expect(last_response.body).to include('Password:')
    end

    it "displays the flash message if no name is given" do
      post '/coaches/signup', {"coach[name]" => "", "coach[password]" => "hello"}
      expect(page).to have_content("Sign up failed, please try again.")
    end

    it "displays the flash message if no password is given" do
      post '/coaches/signup', {"coach[name]" => "Aaron", "coach[password]" => ""}
      expect(page).to have_content("Sign up failed, please try again.")
    end

    it "displays the log in page if username and password is given" do
      post '/signup', {"coach[name]" => "avi", "coach[password]" => "I<3Ruby"}
      follow_redirect!
      expect(last_response.body).to include('Log In')
    end

  end

  describe "Logging In" do
    it "displays Log In Page" do
      get '/coaches/login'
      expect(last_response.body).to include('Name:')
      expect(last_response.body).to include('Password:')
    end

    it "displays the failure message if no username is given" do
      visit '/coaches/login'
      fill_in "username", with: ""
      fill_in "password", with: "test"
      click_button "Log In"
      expect(page.body).to include('Log In failed, please try again.')
    end

    it "displays the failure message if no password is given" do
      visit '/coaches/login'
      fill_in "username", with: "sophie"
      fill_in "password", with: ""
      click_button "Log In"
      expect(page.body).to include('Log In failed, please try again.')
    end

    it "displays the user's account page if username and password is given" do
      @user = User.create(:username => "penelope", :password => "puppies")
      visit '/login'
      fill_in "username", :with => "penelope"
      fill_in "password", :with => "puppies"
      click_button "Log In"
      expect(page.current_path).to eq('/account')
      expect(page.status_code).to eq(200)
      expect(page.body).to include("We are currently working on your account.")
    end
  end

  describe "GET '/logout'" do
    it "clears the session" do
      get '/logout'
      expect{page.get_rack_session_key("user_id")}.to raise_error(KeyError)
    end
  end

  describe "User Model" do
    it "responds to authenticate method from has_secure_password" do
      @user = User.create(:username => "test123", :password => "test")
      expect(@user.authenticate("test")).to be_truthy
    end
  end

end
