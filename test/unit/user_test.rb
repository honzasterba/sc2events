require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should "create from hash" do
    user = User.create_from_hash!('user_info' => { 'name' => 'Dow Jones' })
    assert !user.new_record?
    assert_equal "Dow Jones", user.name
  end

  context "user" do

    setup do
      @user = Factory(:user)
    end

    context "and event exist" do

      setup do
        @event = Factory(:event)
      end

      should "not have starred event" do
        assert !@user.starred_event?(@event)
      end

      context "event starred" do

        setup do
          @star = Factory :star, :user => @user, :event => @event
          @other = Factory :event
        end

        should "have one star" do
          assert_equal 1, @user.stars.count
          assert_equal 1, @user.events.count
        end

        should "now it is starred" do
          assert @user.starred_event?(@event)
        end

        should "not have starred other event" do
          assert !@user.starred_event?(@other)
        end

      end

    end

  end

end
