# frozen_string_literal: true

# Environment configuration - Loads all project dependencies

require 'bundler/setup'
Bundler.require(:default, ENV.fetch('RACK_ENV', 'development'))

# Load environment variables
require 'dotenv'
Dotenv.load

# Set default environment
ENV['RACK_ENV'] ||= 'development'

# Project root path
APP_ROOT = File.expand_path('..', __dir__)

# Load configuration files
require_relative 'database'
require_relative 'routes'

# Autoload models
Dir[File.join(APP_ROOT, 'app', 'models', '*.rb')].sort.each { |file| require file }

# Autoload controllers
Dir[File.join(APP_ROOT, 'app', 'controllers', '*.rb')].sort.each { |file| require file }

# Autoload services
Dir[File.join(APP_ROOT, 'lib', 'services', '*.rb')].sort.each { |file| require file }

# Autoload helpers
Dir[File.join(APP_ROOT, 'lib', 'helpers', '*.rb')].sort.each { |file| require file }

puts "Environment loaded: #{ENV['RACK_ENV']}"
