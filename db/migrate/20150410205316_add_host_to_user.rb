class AddHostToUser < ActiveRecord::Migration
  def change
    add_reference :users, :host, index: true, foreign_key: true
  end
end
