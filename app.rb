require "pry"
require "sinatra"
require "sinatra/reloader"
require "sinatra/json"

# SQL/Database
require "sqlite3"
require_relative "database_setup.rb"

# Models
require_relative "models/question.rb"

# Controllers
require_relative "controllers/main.rb"
