class AddFieldsToUserModel < ActiveRecord::Migration
  def change
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :profile_pic, :string
    add_column :users, :stripe_customer_id, :string
  end
end
