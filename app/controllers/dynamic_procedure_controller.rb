# app/controllers/dynamic_procedure_controller.rb
class DynamicProcedureController < ApplicationController
  include JwtAuthentication
    def index
      procedure_name = params[:procedurename]
      if valid_procedure?(procedure_name)
        records = ActiveRecord::Base.connection.exec_query("EXEC #{procedure_name}")
        render json: records
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
  