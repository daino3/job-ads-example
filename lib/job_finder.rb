module JobFinder
  extend self

  def client
    @client ||= Elasticsearch::Client.new log: true
  end

  def as_search_params(user)

  end

  def search(query_by, lat, long, offset = 0.2)
    top_left_lat = lat + offset
    top_left_lon = long - offset

    top_right_lat = lat - offset
    top_right_lon = long + offset

    puts "    top left: [#{top_left_lat}, #{top_left_lon}]"
    puts "bottom right: [#{top_right_lat}, #{top_right_lon}]"

    search_query =  {
      query: {
        filtered: {
          query:
            text_search(query_by),
            filter: {
              geo_bounding_box: {
                location: {
                  top_left:     { lat: top_left_lat,  lon: top_left_lon},
                  bottom_right: { lat: top_right_lat, lon: top_right_lat}
                }
              }
            }
          }
        }
      }

    JobAd.__elasticsearch__.search(search_query)
  end

  def text_search(query_string)
    {
      multi_match: {
          query: query_string,
          type: "phrase_prefix",
          fuzziness: 1,
          prefix_length: 5,
          fields: [ "title^3", "job_function^3", "job_description", "requirements", "industry"]
        }
    }
  end
end
