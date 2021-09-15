class EventsController < ApplicationController

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, success: "created a event"
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :content, :start_at, :end_at)
  end

end
