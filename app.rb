class App < Sinatra::Base
  register Sinatra::MultiRoute
  configure :development do
    register Sinatra::Reloader
  end

  configure do
    enable :logging
    file = File.new("#{settings.root}/log/#{settings.environment}.log", "a+")
    file.sync = true
    use Rack::CommonLogger, file
  end

  use Rack::Session::Cookie, {
    key: "_html2slim_session",
    path: "/",
    expire_after: 2_592_000, # 30 days
    secret: "ff95aa1813dd96d629fddd29c2159c42351f37952508da880f533e8ed2478e7a"
  }

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
