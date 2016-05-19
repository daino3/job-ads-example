require 'spec_helper'

describe GeoLookup do
  describe '.get_coordinates' do
    it 'returns the coordinates of a US City' do
      expect(GeoLookup.get_coordinates("Chicago", "Illinois")).to eq [41.90, 87.65]
      expect(GeoLookup.get_coordinates("San Francisco", "California")).to eq [37.75, 122.68]
    end

    it 'raises an exception if it cant find the city', :focus do
      expect { GeoLookup.get_coordinates("Nowhere", "BogusState") }.to raise_error(UnknownLocation)
    end
  end
end
