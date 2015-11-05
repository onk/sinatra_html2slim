class App < Sinatra::Base
  register Sinatra::MultiRoute
  configure :development do
    register Sinatra::Reloader
  end

  route :get, :post, "/" do
    @source = params[:source]
    if @source
      @target = HTML2Slim::HTMLConverter.new(params[:source]).to_s
    end
    slim :index
  end
end
