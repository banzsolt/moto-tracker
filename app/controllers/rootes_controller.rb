class RootesController < ApplicationController

  skip_before_filter  :verify_authenticity_token
  layout false

  before_action :confirm_logged_in, :except => [:new_entry]

  def new_entry

    token = request.headers['device-token']
    device = Device.where('device_token = ?', token)[0]
    if device.nil?
      render json: false
    else
      data = params[:data].split(',')
      Location.parseNMEA183(data, device.id)
      render json: true
    end

  end

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
