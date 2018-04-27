class ApplicationController < ActionController::Base
  # TODO - enable this
  # protect_from_forgery with: :exception
  before_action :create_session

private

  def create_session
    id = session[:current_participant_id]
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    session[:current_participant_id] = id
    unless current_participant_id
      begin_session
    end
  end

  def current_participant
    Participant.find(id: session[:current_participant_id])
  end

  def begin_session
    set_current_participant Participant.create(uid: SecureRandom.base64).id
  end

  def current_participant_id
    session[:current_participant_id]
  end

  def set_current_participant participant_id
    session[:current_participant_id] = participant_id
  end

  def clear_current_participant
    session.clear
  end
end
