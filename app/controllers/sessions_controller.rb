class SessionsController < ApplicationController

  def new
  end

  def destroy
    self.current_user = nil
    redirect_to events_path
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.blank?
      flash[:error] = "No authentication supplied"
      redirect_to login_path
    else
      unless @auth = Authorization.find_from_hash(auth)
        @auth = Authorization.create_from_hash(auth, current_user)
      end
      self.current_user = @auth.user
      redirect_to events_path
    end
  end

end
