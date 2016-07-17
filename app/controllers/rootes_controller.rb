class RootesController < ApplicationController

  skip_before_filter  :verify_authenticity_token
  layout false

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

    gon.gps_data = Location.last(100)
    render layout: "application"

  end

end
