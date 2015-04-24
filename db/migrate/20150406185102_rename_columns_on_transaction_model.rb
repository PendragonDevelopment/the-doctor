class RenameColumnsOnTransactionModel < ActiveRecord::Migration
  def change
    rename_column :transactions, :charge_amount, :payment_amount
    rename_column :transactions, :date, :payment_date
  end
end
