class AddIndexToMobilityDatum < ActiveRecord::Migration[6.0]
  def change
    add_index :mobility_data, [:country_region_code, :sub_region_1, :date], name: 'country_region_date', unique: true
  end
end
