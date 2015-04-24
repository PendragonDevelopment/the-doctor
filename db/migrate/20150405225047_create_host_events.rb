class CreateHostEvents < ActiveRecord::Migration
  def change
    create_table :host_events do |t|
      t.references :event, index: true
      t.references :host, index: true
      t.integer :rate

      t.timestamps
    end
  end
end
