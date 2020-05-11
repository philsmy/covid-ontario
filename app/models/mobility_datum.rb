# frozen_string_literal: true

require 'csv'

class MobilityDatum < ApplicationRecord
  def self.import_from_csv
    # ActiveRecord::Base.connection.execute(TRUNCATE patient_data restart identity)
    # PatientDatum.where(country: 'CA', region: 'ON').delete_all

    columns = %i[country_region_code country_region sub_region_1 sub_region_2 date retail_and_recreation_percent_change_from_baseline grocery_and_pharmacy_percent_change_from_baseline parks_percent_change_from_baseline transit_stations_percent_change_from_baseline workplaces_percent_change_from_baseline residential_percent_change_from_baseline]
    upsert_columns = %i[retail_and_recreation_percent_change_from_baseline grocery_and_pharmacy_percent_change_from_baseline parks_percent_change_from_baseline transit_stations_percent_change_from_baseline workplaces_percent_change_from_baseline residential_percent_change_from_baseline]
    values = CSV.read(Rails.root.join('data/Global_Mobility_Report.csv'))[1..-1].reject {|x| x[0] != 'CA' || x[2] != 'Ontario'}

    mobility = MobilityDatum.import columns, values, on_duplicate_key_update: { conflict_target: %i[country_region_code sub_region_1 date], columns: upsert_columns }
  end
end
