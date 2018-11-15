require_relative '../app'
require_relative '../auth'

require "test/unit"
require "rack/test"

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Auth.new(MyApp.new)
  end

  def test_response_is_200
    get '/?login=login&pass=pass'
    assert last_response.status == 200
  end

  def test_response_is_401
    get '/?something=else'
    assert last_response.status == 401
  end
end

