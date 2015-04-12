class CreateHostEvents < ActiveRecord::Migration
  def change
    create_table :host_events do |t|
      t.references :event, index: true, foreign_key: true
      t.references :host, index: true, foreign_key: true
      t.integer :rate

      t.timestamps null: false
    end
  end
end
