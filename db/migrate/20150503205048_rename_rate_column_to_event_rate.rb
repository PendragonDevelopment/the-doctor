class RenameRateColumnToEventRate < ActiveRecord::Migration
  def self.up
  	rename_column :events, :rate, :event_rate
  end

  def self.down
  	rename_column :events, :event_rate, :rate
  end
end
