class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

    def confirm_logged_in
      unless session[:user]
        redirect_to(:controller => 'access', :action => 'login')
        return false
      else
        return true
      end
    end
end
