class Location < ActiveRecord::Base

  belongs_to :device

  def self.parseNMEA183(data, device_id)

    user = User.where('id = ?', Device.where('id = ?', device_id).first.user_id).first

    lat = "#{data[3][0,2]}.#{(data[3][2,7].to_f * 100 / 60).to_s.tr('.','')}"
    long = "#{data[5][0,3]}.#{(data[5][3,7].to_f * 100 / 60).to_s.tr('.','')}"

    location = Location.new(
        time: "20#{data[9][4, 2]}-#{data[9][2, 2]}-#{data[9][0, 2]} #{data[1][0, 2]}:#{data[1][2, 2]}:#{data[1][4, 2]}",
        device_id: device_id,
        latitude: data[4] == 'S' ? '-' + lat : lat,
        longitude: data[6] == 'W' ? '-' + long : long
    )

    if user.trackSpeed
      location.speed = data[7].to_f * 1.15078
    end
    return location

  end



end
