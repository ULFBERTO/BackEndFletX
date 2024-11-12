class DriverLocationChannel < ApplicationCable::Channel
  def subscribed
      stream_from "driver_location_#{params[:driver_id]}"
  end

  def send_location(data)
      ActionCable.server.broadcast "driver_location_#{params[:driver_id]}", data
  end
end