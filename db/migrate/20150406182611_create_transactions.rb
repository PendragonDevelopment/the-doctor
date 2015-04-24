class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :title
      t.integer :charge_amount
      t.date :date
      t.integer :status
      t.string :transaction_record
      t.references :user, index: true, foreign_key: true
      # t.references :host_event, index: true, foreign_key: true
      # Can't set references to host_event before it exists, migration won't work

      t.timestamps null: false
    end
  end
end
