class TicketsController < ApplicationController
  def new
    raise ActionController::RoutingError, "ログイン状態でTickets#newにアクセス"
  end

  def create

  end
end
