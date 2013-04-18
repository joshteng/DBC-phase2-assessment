before do
  @errors = session[:errors]
  @messages = session[:messages]
  session.delete(:errors)
  session.delete(:messages)
end

get '/' do
  erb :index
end

