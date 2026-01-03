class ApplicationController < ActionController::Base
  helper_method :current_aquarium

  private

  def current_aquarium
    @current_aquarium ||= Aquarium.find_by(id: session[:current_aquarium_id])
  end

  def set_current_aquarium(aquarium)
    session[:current_aquarium_id] = aquarium&.id
    @current_aquarium = aquarium
  end
end
