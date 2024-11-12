class AuthenticationController < ApplicationController
  def login
    if valid_credentials?(params[:email], params[:password])
      token = encode_token({ email: params[:email] })
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def valid_credentials?(email, password)
    result = ActiveRecord::Base.connection.exec_query("EXEC validUser '#{email}', '#{password}'")
    result.rows.flatten.first == 0  # Asegurándonos de comparar con el número entero 0
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
