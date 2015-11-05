class App < Sinatra::Base
  register Sinatra::MultiRoute
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  route :get, :post, "/" do
    if params[:source]
      session[:source] = params[:source]
    end
    if session[:source]
      session[:target] = HTML2Slim::HTMLConverter.new(session[:source]).to_s
      redirect to("/") if request.post?
    end
    @source = session[:source]
    @target = session[:target]
    slim :index
  end
end
