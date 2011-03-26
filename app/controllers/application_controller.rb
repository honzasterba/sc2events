class ApplicationController < ActionController::Base

  protect_from_forgery

  layout 'application'  

  protected

    def requires_authentication
      if !current_user
        flash[:error] = 'Log-in required'
        redirect_to events_path
        return false
      end
    end

    def requires_admin_authentication
      if !requires_authentication
        flash[:error] = 'Admin Log-in required'
      elsif !current_user.admin?
        flash[:error] = 'Admin Log-in required'
        redirect_to events_path
        return false
      end
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def signed_in?
      !!current_user
    end

    helper_method :current_user, :signed_in?

    def current_user=(user)
      @current_user = user
      session[:user_id] = user ? user.id : nil
    end

end
