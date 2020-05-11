class Addindextopatientdatum < ActiveRecord::Migration[6.0]
  def change
    add_index :patient_data, [:external_id, :country ,:region], unique: true
  end
end
