class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|

      t.integer 'device_id'
      t.string 'latitude'
      t.string 'longitude'
      t.string 'speed'
      t.string 'time'
      t.timestamps null: false

    end
  end
end
