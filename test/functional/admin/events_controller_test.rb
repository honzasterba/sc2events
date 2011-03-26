require 'test_helper'

class Admin::EventsControllerTest < ActionController::TestCase

  should_require_admin do

    context "new action" do
      should "render new template" do
        get :new
        assert_template 'new'
      end
    end

    context "create action" do
      should "render new template when model is invalid" do
        Event.any_instance.stubs(:valid?).returns(false)
        post :create
        assert_template 'new'
      end

      should "redirect when model is valid" do
        Event.any_instance.stubs(:valid?).returns(true)
        post :create, :event => Factory.attributes_for(:event)
        assert_redirected_to admin_event_path(assigns(:event))
      end
    end

    context "event exists" do

      setup do
        @event = Factory :event
      end

      context "index action" do
        should "render index template" do
          get :index
          assert_template 'index'
        end
      end

      context "show action" do
        should "render show template" do
          get :show, :id => @event
          assert_template 'show'
        end
      end

      context "edit action" do
        should "render edit template" do
          get :edit, :id => @event.id
          assert_template 'edit'
        end
      end

      context "update action" do
        should "render edit template when model is invalid" do
          Event.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @event.id
          assert_template 'edit'
        end

        should "redirect when model is valid" do
          Event.any_instance.stubs(:valid?).returns(true)
          put :update, :id => @event.id
          assert_redirected_to admin_event_path(assigns(:event))
        end
      end

      context "destroy action" do
        should "destroy model and redirect to index action" do
          delete :destroy, :id => @event.id
          assert_redirected_to admin_events_path
          assert !Event.exists?(@event.id)
        end
      end

    end

  end

end
