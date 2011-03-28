class ApplicationController < ActionController::Base

  protect_from_forgery

  layout 'application'

  before_filter :set_time_zone

  protected

    def requires_authentication
      if !current_user
        flash[:error] = 'Log-in required'
        redirect_to login_path
        return false
      else
        return true
      end
    end

    def requires_admin_authentication
      return false unless requires_authentication
      if !current_user.admin?
        flash[:error] = 'Admin Log-in required'
        redirect_to login_path
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

    def set_time_zone
      if params[:time_zone]
        Time.zone = params[:time_zone]
      elsif session && session[:time_zone]
        Time.zone = session[:time_zone]
      end
      session[:time_zone] = Time.zone
    end

    def current_time_zone
      Time.zone
    end

    helper_method :current_time_zone

end
