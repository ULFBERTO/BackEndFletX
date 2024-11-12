class DynamicProceduregeoController < ApplicationController
  include JwtAuthentication

  def get_drivers
    procedure_name = 'GetDrivers'
    
    if valid_procedure?(procedure_name)
      begin
        records = ActiveRecord::Base.connection.exec_query("EXEC #{procedure_name}")

        # Emitir la ubicación de los conductores a través de WebSocket
        records.each do |driver|
          ActionCable.server.broadcast "driver_location_#{driver['id']}", {
            lat: driver['latitude'],
            lon: driver['longitude'],
            name: driver['name'],
            id: driver['id']
          }
        end

        render json: records
      rescue => e
        render json: { error: "Error al ejecutar el procedimiento: #{e.message}" }, status: :internal_server_error
      end
    else
      render json: { error: "Invalid procedure name" }, status: :bad_request
    end
  end

  private

  def valid_procedure?(procedure_name)
    # Aquí puedes agregar validaciones específicas para los procedimientos almacenados
    true
  end
end