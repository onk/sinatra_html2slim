class App < Sinatra::Base
  register Sinatra::MultiRoute
  configure :development do
    register Sinatra::Reloader
  end

  route :get, :post, "/" do
    @source = params[:source]
    @target = params[:target]
    slim :index
  end
end
