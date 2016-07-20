class RootesController < ApplicationController

  before_action :confirm_logged_in

  def index

    @user = User.find(session[:user]['id'])
    @devices = @user.devices

    if !params[:selected_device].nil?
      @seleceted_device = Device.where('id = ? AND user_id = ?', params[:selected_device][:id], session[:user]['id']).first
    end
    if @seleceted_device.nil?
      @seleceted_device = @user.devices.first
    end

    locations = nil
    if !@seleceted_device.nil?
      locations = @seleceted_device.locations.last(100)
    end
    if locations.nil? || locations.count == 0
      locations = [Location.new(:latitude => 0, :longitude => 0)]
    end
    gon.gps_data = locations

    render layout: 'application'

  end

  def create_device

    device = Device.new
    device.description = params[:description].first
    device.user_id = session[:user]['id']

    object= [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    token = (0...50).map { object[rand(object.length)] }.join

    device.device_token = token
    device.save

    redirect_to(:controller => 'rootes', :action => 'index')

  end

end
