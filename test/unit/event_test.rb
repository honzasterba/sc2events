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

    should "have 1 day total" do
      assert_equal 1, @event.days_total
    end

    should "have no days passed" do
      assert_equal 0, @event.days_passed
    end

    context "in progress" do

      setup do
        @event.update_attributes! :starts_at => (2.days.ago - 1.hour)
      end

      should "be in progress" do
        assert !@event.upcoming?
        assert @event.in_progress?
        assert !@event.finished?
      end

      should "have 3 days passed" do
        assert_equal 3, @event.days_passed
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

      should "have 2 days passed" do
        assert_equal 2, @event.days_passed
      end

      should "have 2 days total" do
        assert_equal 2, @event.days_total
      end

    end

  end

  context "multiple events exists" do

    setup do
      @past = Factory :event, :starts_at => 5.days.ago, :ends_at => 3.days.ago
      @now = Factory :event, :starts_at => 2.day.ago, :ends_at => 2.days.from_now
      @never_ending = Factory :event, :starts_at => 1.day.ago
      @future = Factory :event, :starts_at => 2.days.from_now
    end

    should "find current events" do
      assert_equal [@now, @never_ending, @future], Event.current
    end
  end

end
