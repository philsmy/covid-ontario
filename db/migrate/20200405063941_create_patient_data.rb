class CreatePatientData < ActiveRecord::Migration[6.0]
  def change
    create_table :patient_data do |t|
      t.integer :external_id
      t.date :episode_date
      t.string :age_group
      t.string :gender
      t.string :acquisition_info
      t.string :outcome
      t.string :reporter
      t.string :reporter_address
      t.string :reporter_city
      t.string :reporter_postal_code
      t.string :reporter_website
      t.float :reporter_latitude
      t.float :reporter_longitude

      t.timestamps
    end
  end
end
