# entry point
require 'sinatra'
require 'net/http'

# retrieve your api host address like this
#   settings.api => "someaddress.ondigitalocean.com"
set :api, ENV['API_HOST']
set :api_port, ENV['API_PORT'] || 80

# Show a pretty table of all users... rendered on a html page.
get '/' do
  # Use local variable to get response from api
  response = Net::HTTP.get(settings.api, '/users', settings.api_port)
  # pass parsed user list to erb
  @all_users = JSON.parse(response)["all_users"]
  erb :index
end

