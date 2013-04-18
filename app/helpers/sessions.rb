helpers do
  def authenticate!
    unless login?
      store_url_for_redirection
      session[:errors] = "Please login first"
      redirect '/' #should I redirect to login page?
    end
  end

  #move this method to the model?
  #check user exist and ensure the right password entered
  def authenticate(email, password)
    user = User.find_by_email(email) #find user exist in db
    return user if user && user.password == password #authenticate pwd
    nil
  end

  def login(user)
    if user
      session[:messages] = "Hello! You're now logged in."
      session[:current_user_id] = user.id
      redirect_to_the_right_url(user.id)
    else
      session[:errors] = "failed to login"
      redirect '/'
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:current_user_id])
  end

  def login?
    current_user ? true : false
  end

  def store_url_for_redirection
    session[:redirect_url] = request.path
  end

  def redirect_to_the_right_url(user_id)
    url = session[:redirect_url]
    if url
      session.delete(:redirect_url)
      redirect url
    else
      redirect "/users/#{user_id}"
    end
  end

  def logout
    session.delete(:current_user_id)
    session[:messages] = "logged out!"
    redirect '/'
  end
end
