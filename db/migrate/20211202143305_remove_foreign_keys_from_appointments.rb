class RemoveForeignKeysFromAppointments < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :appointments, :doctors
  end
end
