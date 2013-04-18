namespace '/users' do
  get '/new/?' do
    if params[:email]
      user = User.find_by_email(params[:email])
      redirect "/users/#{user.id}" if user
    end
    erb :"users/new"
  end

  post '/?' do
    @user = User.new(params[:user])
    if @user.save
      login(@user)
      session[:message] = "Thanks for signing up!"
      redirect "/users/#{@user.id}"
    else
      @error = "We love you but we failed to sign you up. Please check your information!"
      erb :"/users/new"
    end
  end

  get '/:id' do
    @user = User.find_by_id(params[:id])
    @events_attended = @user.attended_events
    @events_created = @user.created_events
    erb :"users/show"
  end


  get '/:id/edit' do
    @user = User.find_by_id(params[:id])
    if @user
      erb :"users/edit"
    else
      session[:error] = "User not found"
      redirect '/'
    end
  end

  put '/?' do
    user = User.find_by_id(params[:user_id])
    if user && user.update_attributes(params[:user])
      session[:message] = "successfully updated your profile"
      redirect "/users/#{user.id}"
    else
      session[:error] = "failed to update your account. Please try again"
      redirect "/users/#{user.id}/edit"
    end
  end
end
