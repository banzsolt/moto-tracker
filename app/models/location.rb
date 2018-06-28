class Location < ActiveRecord::Base

  belongs_to :device

  def self.parseNMEA183(data, device_id)

    device = Device.find(device_id)

    data.foreach do |element|

      lat = "#{element[3][0,2]}.#{(element[3][2,7].to_f * 100 / 60).to_s.tr('.','')}"
      long = "#{element[5][0,3]}.#{(element[5][3,7].to_f * 100 / 60).to_s.tr('.','')}"

      location = Location.new(
          device_id: device_id,
          latitude: element[4] == 'S' ? '-' + lat : lat,
          longitude: element[6] == 'W' ? '-' + long : long
      )

      location.time = DateTime.parse("20#{element[9][4, 2]}-#{element[9][2, 2]}-#{element[9][0, 2]} #{element[1][0, 2]}:#{element[1][2, 2]}:#{element[1][4, 2]}")

      if device.track_speed
        location.speed = element[7].to_f * 1.15078
      end
      location.save

    end

    #return location

  end



end
