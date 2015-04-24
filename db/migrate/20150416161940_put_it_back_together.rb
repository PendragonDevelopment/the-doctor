class PutItBackTogether < ActiveRecord::Migration
  def change
  	
  	create_table :activities do |t|
      t.string :title

      t.timestamps null: false
    end

    create_table :locations do |t|
    	t.string :title
    	t.text :description
    	t.string :latitude
    	t.string :longitude

    	t.timestamps null: false
    end

  	create_table :events do |t|
      t.references :activity, index: true, foreign_key: true
      t.references :host, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.integer :rate

      t.timestamps null: false
    end

    change_table :transactions do |t|
    	t.references :event, index: true, foreign_key: true
    end

  end
end
