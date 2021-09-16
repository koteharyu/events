class RetirementsController < ApplicationController
  def new

  end

  def create
    if current_user.destroy
      reset_session
      redirect_to root_path, success: "退会しました"
    end
  end
end
