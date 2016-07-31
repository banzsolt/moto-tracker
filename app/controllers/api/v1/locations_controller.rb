class Api::V1::LocationsController < ApplicationController

  skip_before_filter  :verify_authenticity_token
  layout false

  def new

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

  def sms

    device = Device.where('phone_number = ?', params[:sender])[0]
    if device.nil?
      render json: false
    else
      data = params[:message].split(',')
      Location.parseNMEA183(data, device.id)
      render json: true
    end

  end

end