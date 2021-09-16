class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    @events = Event.not_held_events.page(params[:page]).per(10)
  end
end
