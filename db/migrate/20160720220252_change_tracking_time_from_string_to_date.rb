class ChangeTrackingTimeFromStringToDate < ActiveRecord::Migration

  def change
    remove_column :locations, :time
    add_column :locations, :time, :datetime
  end

end
