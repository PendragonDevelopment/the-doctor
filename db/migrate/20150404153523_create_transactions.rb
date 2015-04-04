class CreateTransactions < ActiveRecord::Migration
  def change
    create_table  :transactions do |t|
      t.string  :title
      t.integer :charge_amount
      t.date    :date
      t.integer :status
      t.string  :transaction_record

      t.timestamps
    end
  end
end
