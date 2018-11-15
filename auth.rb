require_relative 'token'

class Auth

  include JWToken

  def initialize(app)
    @app = app
  end

  def call(env)
    @str = env['QUERY_STRING']

    status, header, body = @app.call(env)
    [new_status, header, body << user_token.to_s ]
  end

  private

  def data
    Rack::Utils.parse_nested_query(@str)
  end

  def valid
    {'login' => 'login', 'pass' => 'pass'}
  end

  def data_valid?
    data == valid
  end

  def user_token
    create_token({'login' => 'login'}) if data_valid?
  end

  def new_status
    user_token.nil? ? 401 : 200
  end
end

