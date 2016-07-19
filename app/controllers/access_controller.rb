class AccessController < ApplicationController

  def login

  end

  def attempt_login

    login = false
    if !params[:email].nil? && !params[:password].nil?
      user = User.where('email = ?', params[:email]).first

      if user.authenticate(params[:password])
        login = true
        session[:user] = user
      end
    end

    if login
      redirect_to(:controller => 'rootes', :action => 'index')
    end

  end

end
