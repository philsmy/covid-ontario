class CreateMobilityData < ActiveRecord::Migration[6.0]
  def change
    create_table :mobility_data do |t|
      t.string :country_region_code
      t.string :country_region
      t.string :sub_region_1
      t.string :sub_region_2
      t.date :date
      t.integer :retail_and_recreation_percent_change_from_baseline
      t.integer :grocery_and_pharmacy_percent_change_from_baseline
      t.integer :parks_percent_change_from_baseline
      t.integer :transit_stations_percent_change_from_baseline
      t.integer :workplaces_percent_change_from_baseline
      t.integer :residential_percent_change_from_baseline

      t.timestamps
    end
  end
end
