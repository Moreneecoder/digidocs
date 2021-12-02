class AddAddressAndIsDoctorToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :office_address, :string
    add_column :users, :is_doctor, :boolean
  end
end
