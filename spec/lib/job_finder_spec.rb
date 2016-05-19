require 'spec_helper'

describe JobFinder do

  def seed_job_ads
    Dir[APP_ROOT.join("spec/fixtures/job_ads/*.yml")].each do |file|
      job_yaml = YAML.load_file(file)
      job_attrs = job_yaml.extract!(*JobAd.column_names)
      job_attrs.merge(other: job_yaml.to_a.join(": "))

      if job_attrs["employment_type"].present?
        job_attrs["employment_type"] = job_attrs["employment_type"].parameterize.underscore
      end

      city_and_state = job_attrs["city_and_state"].split(", ")

      lat_and_long = GeoLookup.get_coordinates(city_and_state[0], city_and_state[1])

      JobAd.create!(job_attrs.merge(latitude: lat_and_long[0], longitude: lat_and_long[1]))
    end
  end

  before(:all) do
    seed_job_ads
    JobAd.__elasticsearch__.create_index! index: JobAd.index_name, force: true
    JobAd.import
    sleep 1.5
  end

  after(:all) do
    JobAd.__elasticsearch__.client.indices.delete index: JobAd.index_name
  end

  describe '#search' do
    context 'Accountant' do
      context 'Text Search' do
        it 'searches correctly' do
          response = JobAd.__elasticsearch__.search(query: JobFinder.text_search("accounting"))

          expect(response.records.to_a.count).to eq(3)
        end
      end

      context 'Geolocation ' do
        it 'finds accountants sorted by distance away from' do
          # Search with Chicago Coords
          chicago_coord = GeoLookup.get_coordinates("Chicago", "Illinois")
          chi_response = JobFinder.search("accounting", chicago_coord[0], chicago_coord[1])

          chi_ads = chi_response.records.to_a
          expect(chi_ads.count).to eq(2)
          expect(chi_ads[0].city_and_state).to eq("Chicago, Illinois")
          expect(chi_ads[0].job_function).to eq("Accounting/Auditing")
          expect(chi_ads[1].city_and_state).to eq("Chicago, Illinois")
          expect(chi_ads[1].job_function).to eq("Finance")

          # Search with New York Coords
          ny_coord = GeoLookup.get_coordinates("New York", "New York")
          ny_response = JobFinder.search("accounting", ny_coord[0], ny_coord[1])

          ny_ads = ny_response.records.to_a
          expect(ny_ads.count).to eq(1)
          expect(ny_ads[0].city_and_state).to eq("New York, New York")
          expect(ny_ads[0].job_function).to eq("Finance, Analyst")
        end
      end
    end
  end
end
