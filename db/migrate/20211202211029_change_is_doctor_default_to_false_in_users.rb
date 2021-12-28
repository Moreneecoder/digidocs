class ChangeIsDoctorDefaultToFalseInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :is_doctor, false
  end
end
