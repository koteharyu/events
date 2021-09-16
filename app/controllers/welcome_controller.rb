class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    @events = Event.not_held_events.page(params[:page]).per(10)
    @event_search_form = EventSearchForm.new(event_search_form_params)
  end

  private

  def event_search_form_params
    params.fetch(:event_search_form, {}).permit(:keyword, :start_at).merge(page: params[:page])
  end
end
