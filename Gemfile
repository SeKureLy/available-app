# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

# Web
gem 'puma', '~>5.3.1'
gem 'rack-cors'
gem 'roda'

# Configuration
gem 'figaro'
gem 'rake'

# Debugging
gem 'pry'

# Communication
gem 'http'
gem 'redis'
gem 'redis-rack'

# Security
gem 'rack-ssl-enforcer'
gem 'rbnacl' # assumes libsodium package already installed

# Development
group :development do
  gem 'rubocop'
  gem 'rubocop-performance'
end

# Testing
group :test do
  gem 'minitest'
  gem 'minitest-rg'
  gem 'webmock'
end

group :development, :test do
  gem 'rack-test'
  gem 'rerun'
end
