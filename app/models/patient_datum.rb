# frozen_string_literal: true

require 'csv'

class PatientDatum < ApplicationRecord
  def self.import_from_csv
    # ActiveRecord::Base.connection.execute("TRUNCATE patient_data restart identity")
    # PatientDatum.where(country: 'CA', region: 'ON').delete_all

    columns = %i[external_id episode_date age_group gender acquisition_info outcome reporter reporter_address reporter_city reporter_postal_code reporter_website reporter_latitude reporter_longitude country region]
    upsert_columns = %i[episode_date age_group gender acquisition_info outcome reporter reporter_address reporter_city reporter_postal_code reporter_website reporter_latitude reporter_longitude]
    values = CSV.read(Rails.root.join('data/conposcovidloc.csv'))[1..-1]
    (0..(values.size - 1)).each do |i|
      values[i] << 'CA'
      values[i] << 'ON'
      # p values[i]
    end

    # patients = PatientDatum.import columns, values, validate: false
    patients = PatientDatum.import columns, values, on_duplicate_key_update: {conflict_target: [:external_id, :country ,:region], columns: upsert_columns}
  end
end
