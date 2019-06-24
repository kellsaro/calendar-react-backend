class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :title
      t.datetime :appt_time
      t.references :user, foreign_key: true, dependent: :destroy

      t.timestamps
    end
  end
end
