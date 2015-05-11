class ChangeLatitudeAndLongitudeTypes < ActiveRecord::Migration
  def change
    change_column :locations, :latitude, 'float USING CAST(latitude AS float)'
    change_column :locations, :longitude, 'float USING CAST(longitude AS float)'
  end
end
