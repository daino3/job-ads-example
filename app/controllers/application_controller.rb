module JobAdsExampleApp
  class App < Sinatra::Base

    before "*" do
    end

    get '/' do
      slim :index, layout: true
    end

  end
end
