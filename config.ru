require './app'
require './auth'

use Rack::Reloader
use Auth
run MyApp.new
