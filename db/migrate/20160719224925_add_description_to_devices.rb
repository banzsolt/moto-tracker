class AddDescriptionToDevices < ActiveRecord::Migration
  def change
    add_column("devices", "description", :text)
  end
end
