namespace '/event-attendance' do
  post '/attend' do
    user = User.find_by_id(params[:user_id])
    event = Event.find_by_id(params[:event_id])
    if user && event
      user.attended_events << event
      session[:messages] = "Successfully join event"
    else
      session[:errors] = "Failed to join event"
    end
    redirect "/events/#{event.id}"
  end

  delete '/unattend' do
    event = Event.find_by_id(params[:event_id])
    if event
      attendance = EventUser.find_by_user_id_and_event_id(params[:user_id], params[:event_id])
    end

    if attendance
      attendance.destroy
      session[:errors] = "No longer attending #{event.name}"
    else
      session[:errors] = "no such attendance"
    end
    redirect "/events/#{params[:event_id]}"
  end

end
