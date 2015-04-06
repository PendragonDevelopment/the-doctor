class RemoveStripeCustomerIdFromUserModelAndAddItToTransactionModel < ActiveRecord::Migration
  def change
    remove_column :users, :stripe_customer_id, :integer
    add_column :transactions, :stripe_customer_id, :string
  end
end
