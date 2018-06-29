class RootesController < ApplicationController

  before_action :confirm_logged_in

  def index

    @user = User.find(session[:user]['id'])
    number_of_history = 1400

    locations = nil

    if !params[:selected_device].nil?
      @seleceted_device = Device.where('id = ? AND user_id = ?', params[:selected_device][:id], session[:user]['id']).first

      date_from = DateTime.parse("#{params[:selected_device]['date_from(1i)']}-#{params[:selected_device]['date_from(2i)']}-#{params[:selected_device]['date_from(3i)']}")
      date_to = DateTime.parse("#{params[:selected_device]['date_to(1i)']}-#{params[:selected_device]['date_to(2i)']}-#{params[:selected_device]['date_to(3i)']}")

      locations = @seleceted_device.locations.where('time BETWEEN ? AND ?', date_from, date_to).last(number_of_history)

    end

    if @seleceted_device.nil?
      @seleceted_device = @user.devices.first
    end


    if !@seleceted_device.nil?
      if params[:selected_device].nil?
        locations = @seleceted_device.locations.last(number_of_history)
      end
    end

    if locations.nil? || locations.count == 0
      locations = [Location.new(:latitude => 0, :longitude => 0)]
      @seleceted_device = Device.new(:description => '')
    end
    gon.gps_data = locations

    render layout: 'application'

  end

end
