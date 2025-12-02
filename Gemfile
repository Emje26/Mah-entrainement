# frozen_string_literal: true

source 'https://rubygems.org'

ruby '>= 3.0.0'

# Rails framework
gem 'rails', '~> 7.1.0'

# The original asset pipeline for Rails
gem 'sprockets-rails'

# Use SQLite as the database for Active Record
gem 'sqlite3', '~> 1.6'

# Use the Puma web server
gem 'puma', '~> 6.0'

# Use JavaScript with ESM import maps
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator
gem 'turbo-rails'

# Hotwire's modest JavaScript framework
gem 'stimulus-rails'

# Build JSON APIs with ease
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 5.0'

# Use Kredis to get higher-level data types in Redis
# gem 'kredis'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants
# gem 'image_processing', '~> 1.2'

# HTTP Client
gem 'httparty', '~> 0.21'

# HTML Parsing
gem 'nokogiri', '~> 1.15'

group :development, :test do
  # Debugging
  gem 'debug', platforms: %i[mri windows]

  # RSpec for testing
  gem 'rspec-rails', '~> 6.0'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.2'

  # Environment variables
  gem 'dotenv-rails', '~> 2.8'
end

group :development do
  # Use console on exceptions pages
  gem 'web-console'

  # Speed up commands on slow machines / big apps
  # gem 'spring'

  # Code quality
  gem 'rubocop', '~> 1.50', require: false
  gem 'rubocop-rails', '~> 2.19', require: false
  gem 'rubocop-performance', '~> 1.17', require: false

  # Better error pages
  gem 'better_errors'
  gem 'binding_of_caller'

  # N+1 query detection
  gem 'bullet'

  # Annotate models with schema
  gem 'annotate'
end

group :test do
  # Use system testing
  gem 'capybara'
  gem 'selenium-webdriver'

  # Code coverage
  gem 'simplecov', require: false

  # Database cleaner
  gem 'database_cleaner-active_record'

  # Shoulda matchers for RSpec
  gem 'shoulda-matchers', '~> 5.0'
end
