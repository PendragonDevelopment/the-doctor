class FuckShitUp < ActiveRecord::Migration
  def change
  	execute "DROP TABLE #{:host_events} CASCADE"
  	execute "DROP TABLE #{:events} CASCADE"
  end

end
