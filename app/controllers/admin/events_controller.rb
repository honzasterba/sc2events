class Admin::EventsController < ApplicationController

  layout 'admin'

  before_filter :requires_admin_authentication
  around_filter :switch_time_zone_for_event, :only => [:create, :update]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "Successfully created event."
      redirect_to admin_event_path(@event)
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    Time.zone = @event.zone
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated event."
      redirect_to admin_event_path(@event)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Successfully destroyed event."
    redirect_to admin_events_path
  end

  protected

    def switch_time_zone_for_event
      z = Time.zone
      Time.zone = params[:event][:time_zone]
      yield
      Time.zone = z
    end
end
