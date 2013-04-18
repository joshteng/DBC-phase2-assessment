namespace '/events' do

  before '/new' do
    authenticate!
  end

  get '/new/?' do
    erb :"events/new"
  end


  before '/?', method: :post do
    authenticate!
  end

  post '/?' do
    @event = current_user.events.build(params[:event])
    if @event.save
      session[:messages] = "Successfully created event!"
      redirect "/events/#{@event.id}"
    else
      session[:errors] = "Failed to create event. PLease try again"
      erb :"events/new"
    end
  end

  post '.json' do
    @event = current_user.events.build(params[:event])
    if @event.save
      erb :"events/_event_row", layout: false, locals: { e: @event }
    else
      406
    end
  end


  get '/?' do
    @events = Event.all
    erb :"events/index"
  end

  get "/:id" do
    @event = Event.find_by_id(params[:id])
    if @event
      erb :"events/show"
    else
      session[:errors] = "Event not found"
      redirect '/events'
    end
  end


  get '/:id/edit/?' do
    @event = Event.find_by_id(params[:id])
    erb :"events/edit"
  end

  put '/?' do
    @event = Event.find_by_id(params[:event_id])
    if @event && @event.update_attributes(params[:event])
      redirect "/events/#{@event.id}"
    else
      @errors = "Error updating event"
      erb :"events/edit"
    end
  end

  delete '/' do
    event = Event.find_by_id(params[:event_id])
    event.destroy
    redirect '/events'
  end


end
