class App < Sinatra::Base
  register Sinatra::MultiRoute
  configure :development do
    register Sinatra::Reloader
  end

  route :get, :post, "/" do
    slim :index
  end
end
