# frozen_string_literal: true

source 'https://rubygems.org'

ruby '>= 3.0.0'

# Core
gem 'bundler', '~> 2.0'
gem 'rake', '~> 13.0'

# Web framework (choose one)
gem 'sinatra', '~> 3.0'
# gem 'rack', '~> 3.0'

# Database
gem 'sqlite3', '~> 1.6'
# gem 'pg', '~> 1.5'           # PostgreSQL
# gem 'mysql2', '~> 0.5'       # MySQL

# ORM
# gem 'sequel', '~> 5.0'
# gem 'activerecord', '~> 7.0'

# Environment
gem 'dotenv', '~> 2.8'

# JSON
gem 'json', '~> 2.6'

# HTTP Client
gem 'httparty', '~> 0.21'

# HTML Parsing
gem 'nokogiri', '~> 1.15'

# Template Engine
gem 'erb', '~> 4.0'
# gem 'slim', '~> 5.0'
# gem 'haml', '~> 6.0'

group :development do
  gem 'pry', '~> 0.14'
  gem 'rubocop', '~> 1.50', require: false
  gem 'rubocop-performance', '~> 1.17', require: false
end

group :test do
  gem 'rspec', '~> 3.12'
  gem 'rack-test', '~> 2.1'
  gem 'factory_bot', '~> 6.2'
  gem 'faker', '~> 3.2'
  gem 'simplecov', '~> 0.22', require: false
end

group :development, :test do
  gem 'debug', '~> 1.8'
end
