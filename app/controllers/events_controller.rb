class EventsController < ApplicationController

  def new
    @event = current_user.created_event.build
  end

  def create
    @event = current_user.created_event.create(event_params)
    if @event.save
      redirect_to @event, success: "created a event"
    else
      flash.now[:danger] = "faild to create a event"
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :content, :start_at, :end_at)
  end
end
