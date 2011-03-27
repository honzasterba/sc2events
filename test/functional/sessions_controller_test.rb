require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  should "show login" do
    get :new
    assert_response :success
    assert_template "new"
  end

  should "redirect from login if no auth data" do
    post :create, :provider => "test"
    assert_redirected_to login_path
  end

  context "user exists" do

    setup do
      @user = Factory :user
      @auth = Authorization.new(:user => @user)
    end

    should "log user in if auth supplied" do
      @request.stubs(:env).returns({'omniauth.auth' => true})
      Authorization.expects(:find_from_hash).returns(@auth)
      post :create, :provider => "test"
      assert_redirected_to events_path
      assert_equal @user.id, session[:user_id]
    end

    context "logged in" do

      setup do
        session[:user_id] = @user.id
      end

      should "log user out" do
        get :destroy
        assert_redirected_to events_path
        assert_nil session[:user_id]
      end

    end

  end


end
