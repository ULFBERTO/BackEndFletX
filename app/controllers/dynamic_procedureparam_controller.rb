class DynamicProcedureparamController < ApplicationController
    include JwtAuthentication
  
    def index
      procedure_name = params[:procedurename]
      list_charges = params[:Valor]
  
      logger.debug "Valor de list_charges: #{list_charges}"
      
      if valid_procedure?(procedure_name)
        # Asegúrate de que list_charges no esté vacío
        if list_charges.present?
          list_charges = ActiveRecord::Base.connection.quote(list_charges)
          query = "EXEC #{procedure_name} @listcharges = #{list_charges}"
  
          begin
            records = ActiveRecord::Base.connection.exec_query(query)
            render json: records
          rescue => e
            logger.error "Error ejecutando el procedimiento: #{e.message}"
            render json: { error: "Error al ejecutar el procedimiento" }, status: :internal_server_error
          end
        else
          render json: { error: "Parameter list_charges is required" }, status: :bad_request
        end
      else
        render json: { error: "Invalid procedure name" }, status: :bad_request
      end
    end
  
    private
  
    def valid_procedure?(procedure_name)
      # Aquí puedes agregar validaciones específicas para los procedimientos almacenados si es necesario
      true
    end
  end
  