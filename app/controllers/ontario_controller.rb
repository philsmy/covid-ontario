# frozen_string_literal: true

class OntarioController < ApplicationController
  # skip_before_filter :verify_authenticity_token, only: :map_data
  protect_from_forgery except: :map_data

  def index
    @patients = PatientDatum.where(region: 'ON').group(:reporter, :reporter_latitude, :reporter_longitude).count
    @patients_chart = PatientDatum.where(region: 'ON').group_by_day(:episode_date).count
    
    sum = 0
    @patients_chart_sum = PatientDatum.where(region: 'ON').group_by_day(:episode_date).count.map { |x,y| { x => (sum += y)} }.reduce({}, :merge)
    
    @gender = PatientDatum.where(region: 'ON').group(:gender).count
    @age_group = PatientDatum.where(region: 'ON').group(:age_group).count
    @outcome = PatientDatum.where(region: 'ON').group(:outcome).count

    @retail_and_recreation_percent_change_from_baseline = {}
    MobilityDatum.where(sub_region_1: 'Ontario').all.each do |md|
      @retail_and_recreation_percent_change_from_baseline[md.date] = md.retail_and_recreation_percent_change_from_baseline
    end
    @grocery_and_pharmacy_percent_change_from_baseline = {}
    MobilityDatum.where(sub_region_1: 'Ontario').all.each do |md|
      @grocery_and_pharmacy_percent_change_from_baseline[md.date] = md.grocery_and_pharmacy_percent_change_from_baseline
    end
    @parks_percent_change_from_baseline = {}
    MobilityDatum.where(sub_region_1: 'Ontario').all.each do |md|
      @parks_percent_change_from_baseline[md.date] = md.parks_percent_change_from_baseline
    end
    @transit_stations_percent_change_from_baseline = {}
    MobilityDatum.where(sub_region_1: 'Ontario').all.each do |md|
      @transit_stations_percent_change_from_baseline[md.date] = md.transit_stations_percent_change_from_baseline
    end
    @workplaces_percent_change_from_baseline = {}
    MobilityDatum.where(sub_region_1: 'Ontario').all.each do |md|
      @workplaces_percent_change_from_baseline[md.date] = md.workplaces_percent_change_from_baseline
    end
    @residential_percent_change_from_baseline = {}
    MobilityDatum.where(sub_region_1: 'Ontario').all.each do |md|
      @residential_percent_change_from_baseline[md.date] = md.residential_percent_change_from_baseline
    end


  end
  
  def district
    @district = params[:district]
    @patients_chart = PatientDatum.where(region: 'ON').where(reporter: params[:district]).group_by_day(:episode_date).count
    @gender = PatientDatum.where(region: 'ON').where(reporter: params[:district]).group(:gender).count
    sum = 0
    @patients_chart_sum = PatientDatum.where(region: 'ON').where(reporter: params[:district]).group_by_day(:episode_date).count.map { |x,y| { x => (sum += y)} }.reduce({}, :merge)
    @age_group = PatientDatum.where(region: 'ON').where(reporter: params[:district]).group(:age_group).count
    @outcome = PatientDatum.where(region: 'ON').where(reporter: params[:district]).group(:outcome).count
  end

  def map_data
    @patients = PatientDatum.where(region: 'ON').group(:reporter, :reporter_latitude, :reporter_longitude, :reporter_website).count
    @patient_map = @patients.keys.map do |key|
      {
        'type': 'Feature',
        "geometry": {
          "type": 'Point',
          "coordinates": [
            key[2],
            key[1]
          ]
        },
        "properties": {
          'reporter': key[0],
          'num_cases': @patients[key],
          'website': key[3]
        }
      }
    end

    result_string = "eqfeed_callback({ 'type': 'FeatureCollection', 'features': #{@patient_map.to_json} });"

    respond_to do |format|
      format.js { render json: result_string }
    end
  end
end
