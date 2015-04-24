class AddProfilePicAttachmentToUsers < ActiveRecord::Migration
  def self.up
    add_attachment :users, :profile_pic
    remove_column :users, :profile_pic, :string
  end

  def self.down
    remove_attachment :users, :profile_pic
    add_column :users, :profile_pic, :string
  end
end