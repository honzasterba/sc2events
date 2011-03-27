require 'test_helper'

class StarTest < ActiveSupport::TestCase

  should belong_to(:event)
  should belong_to(:user)

  context "event exists" do

    setup do
      @event = Factory :event
    end

    should "update event counter cache on creation" do
      assert_difference '@event.stars_count' do
        Factory :star, :event => @event
        @event.reload
      end
    end

  end


end
