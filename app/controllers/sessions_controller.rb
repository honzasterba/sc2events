class SessionsController < ApplicationController

  def new
  end

  def destroy
    self.current_user = nil
    redirect_to events_path
  end

  def create
    auth = request.env['rack.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user

    redirect_to events_path
  end

end
