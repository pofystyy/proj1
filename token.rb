module JWToken

  require 'jwt'

  ALGO = 'RS256'

  def rsa_private
    rsa_private = OpenSSL::PKey::RSA.generate 2048
  end

  def rsa_public
    rsa_public = rsa_private.public_key
  end

  def create_token payload
    JWT.encode payload, rsa_private, ALGO
  end

  def decoded token
    begin
      JWT.decode token, rsa_public, true, { :algorithm => ALGO }
    rescue JWT::ExpiredSignature
    end
  end

end
