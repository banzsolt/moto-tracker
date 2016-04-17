class RootesController < ApplicationController

  skip_before_filter  :verify_authenticity_token
  layout false

  def new_entry

    token = request.headers['device-token']
    device = Device.where('device_token = ?', token)[0]
    if device.nil?
    else
      puts params
      new_location = Location.new(params.permit(:latitude, :longitude, :speed, :time))
      new_location.device = device
      new_location.save
    end

  end

end
