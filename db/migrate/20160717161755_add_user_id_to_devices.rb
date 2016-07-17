class AddUserIdToDevices < ActiveRecord::Migration
  def change
    add_column("devices", "user_id", :integer, null: false, default: 0)
  end
end
