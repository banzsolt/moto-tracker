class ChangeTrackingTimeFromStringToDate < ActiveRecord::Migration

  def up
    change_column :locations, :time, :datetime
  end

  def down
    change_column :locations, :time, :string
  end

end
