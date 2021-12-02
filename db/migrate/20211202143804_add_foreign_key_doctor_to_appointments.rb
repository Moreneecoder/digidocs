class AddForeignKeyDoctorToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :appointments, :users, column: :doctor_id
  end
end
