class RootesController < ApplicationController

  skip_before_filter  :verify_authenticity_token
  layout false

  def new_entry

    token = request.headers['device-token']
    device = Device.where('device_token = ?', token)[0]
    if device.nil?
      render json: false
    else
      puts params
      new_location = Location.new(params.permit(:latitude, :longitude, :speed))
      new_location.time = "20#{params[:date][4, 2]}-#{params[:date][2, 2]}-#{params[:date][0, 2]} #{params[:time][0, 2]}:#{params[:time][2, 2]}:#{params[:time][4, 2]}"
      new_location.device = device
      new_location.save

      render json: true
    end



  end

  def index

    gon.gps_data = Location.last(100)
    render layout: "application"

  end

end
