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

  use Rack::Session::Dalli, {
    namespace: "html2slim.session",
    key: "_html2slim_session",
    expire_after: 2_592_000, # 30 days
  }

  route :get, :post, "/" do
    if params[:source]
      session[:source] = params[:source]
      session[:target] = HTML2Slim::HTMLConverter.new(session[:source]).to_s
      redirect to("/")
    end

    @source = session[:source]
    @target = session[:target]
    session.clear
    slim :index
  end
end
