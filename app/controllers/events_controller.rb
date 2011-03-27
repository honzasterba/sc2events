class EventsController < ApplicationController

  before_filter :requires_authentication, :only => [ :star, :unstar ]
  before_filter :find_event, :only => [ :star, :unstar ]

  def index
    @events = Event.current
  end

  def star
    if !current_user.starred_event?(@event)
      current_user.stars.create(:event => @event)
    end
    respond_to do |format|
      format.js { render :partial => "event", :locals => { :event => @event } }
      format.html { redirect_to events_path }
    end
  end

  def unstar
    if star = current_user.starred_event?(@event)
      star.destroy
    end
    respond_to do |format|
      format.js { render :partial => "event", :locals => { :event => @event } }
      format.html { redirect_to events_path }
    end
  end

  private

    def find_event
      @event = Event.find(params[:id])
    end

end
