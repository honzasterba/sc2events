require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  should "render index" do
    get :index
    assert_response :success
    assert_template "index"
  end

  context "some events exist" do

    setup do
      3.times do
        Factory(:event)
      end
    end

    should "show index" do
      get :index
      assert_response :success
    end

  end

  context "event" do

    setup do
      @event = Factory :event
    end

    [:star, :unstar].each do |a|

      should "require login for #{a}" do
        post a, :id => @event.id
        assert_redirected_to login_path
      end

    end

    logged_in do

      should "get starred" do
        post :star, :id => @event
        assert_equal 1, @user.stars.count
        assert_equal @event, @user.events.first
        assert_redirected_to events_path
      end

      should "get starred XHR" do
        xhr :post, :star, :id => @event
        assert @user.starred_event?(@event)
        assert_template "_event"
      end

      context "starred" do

        setup do
          Factory :star, :event => @event, :user => @user
        end

        should "get unstarred" do
          post :unstar, :id => @event
          @user.reload
          assert @user.stars.blank?
          assert_redirected_to events_path
        end

        should "get unstarred XHR" do
          xhr :post, :unstar, :id => @event
          assert !@user.starred_event?(@event)
          assert_template "_event"
        end

      end

    end

  end

end
