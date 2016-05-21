module JobAdsExampleApp
  class App < Sinatra::Base

    get '/users' do
      @users = User.includes(:jobs).all
      @jobs = JobAd.all

      slim :users, layout: true
    end

    get '/users/:id' do
      @user = User.find(params[:id])
      current_loc = @user.current_job.location
      city_state = current_loc.split(", ")

      job_coords = GeoLookup.get_coordinates(city: city_state[0], state: city_state[1])
      response = JobFinder.search(@user.current_job.industry, job_coords[0], job_coords[1])

      @jobs = response.records.to_a.uniq { |j| j.title }

      slim :show, layout: true
    end

    get '/new-ad' do
      @job_ad = JobAd.new

      slim :form, layout: true
    end
  end
end
