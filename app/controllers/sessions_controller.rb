namespace "/sessions" do
  post '/login' do
    user = authenticate(params[:email], params[:password])
    login(user)
  end

  delete '/logout' do
    logout
  end

end
