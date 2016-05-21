class JobAd < ActiveRecord::Base
  include Elasticsearch::Model

  index_name "job_ads-#{ENV['RACK_ENV']}"

  # enum employment_type: { part_time: 0, full_time: 1 }

  settings do
    mappings do
      indexes :employment_type, type: 'string'
      indexes :company, type: 'string'
      indexes :compensation, type: 'string'
      indexes :experience, type: 'string'
      indexes :industry, type: 'string'
      indexes :job_function, type: 'string'
      indexes :title, type: 'string'
      indexes :company_description, type: 'string'
      indexes :job_description, type: 'string'
      indexes :requirements, type: 'string'
      indexes :other, type: 'string'
      indexes :location, type: 'geo_point'
      indexes :id
    end
  end

  after_commit on: [:destroy] do
    __elasticsearch__.delete_document
  end

  def as_indexed_json(options={})
    as_json(except: [:latitude, :longitude]).merge(location: { lat: latitude, lon: longitude })
  end
end
