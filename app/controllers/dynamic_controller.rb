# app/controllers/dynamic_controller.rb
class DynamicController < ApplicationController
    def index
      table_name = params[:tableN]
      if valid_table?(table_name)
        records = ActiveRecord::Base.connection.exec_query("SELECT * FROM #{table_name}")
        render json: records
      else
        render json: { error: "Invalid table name" }, status: :bad_request
      end
    end
  
    private
  
    def valid_table?(table_name)
      ActiveRecord::Base.connection.data_source_exists?(table_name)
    end
  end
  