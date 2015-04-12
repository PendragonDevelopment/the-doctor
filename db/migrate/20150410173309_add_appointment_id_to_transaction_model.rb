class AddAppointmentIdToTransactionModel < ActiveRecord::Migration
  def change
    add_column :transactions, :appointment_id, :integer
  end
end
