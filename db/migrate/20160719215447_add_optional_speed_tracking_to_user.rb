class AddOptionalSpeedTrackingToUser < ActiveRecord::Migration
  def change
    add_column("users", "trackSpeed", :boolean, null: false, default: true)
  end
end
