require 'test_helper'

class EventTest < ActiveSupport::TestCase

  should validate_presence_of(:name)

  context "an event" do

    setup do
      @event = Factory :event, :starts_at => 3.days.from_now.to_date
    end

    should "validate finished after started" do
      assert @event.valid?
      @event.ends_at = 4.days.ago.to_date
      assert !@event.valid?
      @event.ends_at = 4.days.from_now.to_date
      assert @event.valid?
    end

    should "be upcoming" do
      assert @event.upcoming?
      assert !@event.in_progress?
      assert !@event.finished?
    end

    should "be incomplete" do
      assert @event.incomplete?
    end

    context "in progress" do

      setup do
        @event.update_attributes! :starts_at => 2.day.ago.to_date
      end

      should "be in progress" do
        assert !@event.upcoming?
        assert @event.in_progress?
        assert !@event.finished?
      end

    end

    context "finished" do

      setup do
        @event.update_attributes! :starts_at => 2.day.ago.to_date
        @event.update_attributes! :ends_at => 1.day.ago.to_date
      end

      should "be finished" do
        assert @event.finished?
        assert !@event.upcoming?
        assert !@event.in_progress?
      end

      should "not be incomplete" do
        assert !@event.incomplete?
      end
    end

  end

end
