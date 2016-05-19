module GeoLookup
  extend self

  def get_coordinates(city, state)
    begin
      lookup.fetch(state).fetch(city)
    rescue KeyError
      raise UnknownLocation.new(city, state)
    end
  end

  private

  def lookup
    @lookup ||= YAML.load_file(APP_ROOT.join("spec/fixtures/us_cities.yml"))
  end
end

class UnknownLocation < StandardError
  def initialize(city, state)
    message ||= "Unable to find location #{city} #{state}"
    super(message)
  end
end
