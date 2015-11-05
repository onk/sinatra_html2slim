class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    slim :index
  end
end
