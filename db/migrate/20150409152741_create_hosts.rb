class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.integer :rating
      t.boolean :active
      t.string :bio
      t.references :user, index: true, foreign_key: true
      t.date :birthdate
      t.integer :status
      t.string :resume
      t.string :direct_deposit
      t.string :voided_check
      t.string :w9

      t.timestamps null: false
    end
  end
end
