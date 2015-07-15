require "pry"
require "sinatra"
require "sinatra/reloader"
require "sinatra/json"
#require "sinatra/cross_origin"


# SQL/Database
require "sqlite3"
require_relative "database_setup.rb"

# Models
require_relative "models/assignment.rb"
require_relative "models/collab.rb"
require_relative "models/link.rb"

# Controllers
require_relative "controllers/main.rb"
require_relative "controllers/api_controller.rb"

configure do
  enable :cross_origin
end
