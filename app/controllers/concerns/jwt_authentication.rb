# app/controllers/concerns/jwt_authentication.rb
module JwtAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    # Obtener el token del encabezado Authorization
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    # Decodificar el token y obtener el email
    decoded = jwt_decode(header)
    
    # Aquí no estamos buscando un usuario en la base de datos, sino que usamos el email
    @current_user_email = decoded[:email]
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    # Si el token no es válido o no se puede decodificar, devolver un error 401
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end

  # Decodificar el token JWT utilizando la clave secreta
  def jwt_decode(token)
    decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')[0]
    HashWithIndifferentAccess.new decoded
  end

  # Codificar el token JWT con un payload
  def jwt_encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end
end
