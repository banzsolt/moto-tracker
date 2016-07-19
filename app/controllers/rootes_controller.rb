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


    @user = User.find(session[:user]["id"])
    @devices = @user.devices

    @selectedDevice = @user.devices.first

    puts "The devices are"
    puts @devices

    gon.gps_data = Location.last(100)
    render layout: "application"

  end

end
