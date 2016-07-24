class DeviceController < ApplicationController

  before_action :confirm_logged_in

  def index

    @user = User.find(session[:user]['id'])

  end

  def new

    device = Device.new
    device.description = params[:description].first
    device.user_id = session[:user]['id']

    object= [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    token = (0...50).map { object[rand(object.length)] }.join

    device.device_token = token
    device.save

    redirect_to(:controller => 'rootes', :action => 'index')

  end

  def show

    @user = User.find(session[:user]['id'])

  end

  def delete

    if !params[:id].nil?
      @device = Device.find(params[:id])

      if @device.user_id == session[:user]['id']
        @device.deleted = true
        @device.save
      end

    end

    redirect_to(:controller => 'device', :action => 'index')

  end

  def edit

    if params[:id].nil?
      redirect_to(:controller => 'device', :action => 'index')
      return
    end

    @device = Device.find(params[:id])

    if @device.user_id != session[:user]['id']
      redirect_to(:controller => 'device', :action => 'index')
    end

  end

  def update

    if !params[:id].nil?
      @device = Device.find(params[:id])

      if @device.user_id == session[:user]['id']
        @device.description = params[:device][:description]
        @device.track_speed = params[:device][:track_speed]
        @device.save
      end
    end

    redirect_to(:controller => 'device', :action => 'index')

  end


end
