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
    @starred_event = @event
    respond_to do |format|
      format.js { render :partial => "sidebar_update" }
      format.html { redirect_to events_path }
    end
  end

  def unstar
    @unstarred_event = @event
    respond_to do |format|
      format.js { render :partial => "sidebar_update" }
      format.html { redirect_to events_path }
    end
    if star = current_user.starred_event?(@event)
      star.destroy
    end
  end

  private

    def find_event
      @event = Event.find(params[:id])
    end

end
