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

end
