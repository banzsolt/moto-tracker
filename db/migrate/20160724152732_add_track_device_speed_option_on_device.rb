class AddTrackDeviceSpeedOptionOnDevice < ActiveRecord::Migration
  def change
    add_column :devices, :track_speed, :boolean, default: true
    add_column :devices, :deleted, :boolean, default: false
    remove_column :users, :trackSpeed
  end
end
