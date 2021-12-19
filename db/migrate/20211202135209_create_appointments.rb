class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :doctor, null: false
      t.string :title
      t.text :description
      t.datetime :time

      t.timestamps
    end

    add_foreign_key :appointments, :users, column: :doctor_id
  end
end
