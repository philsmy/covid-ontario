class AddCountryAndRegionToPatientDatum < ActiveRecord::Migration[6.0]
  def change
    add_column :patient_data, :country, :string
    add_column :patient_data, :region, :string
  end
end
