source 'https://rubygems.org'

ruby '1.9.3'

gem 'therubyracer'
gem 'authlogic'
gem 'time_diff'

# needed for image upload
gem "rmagick"
gem "carrierwave"

gem 'passenger'
gem 'rails', '3.2.12'
gem 'rb-readline'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# heroku doesn't support sqlite and it will bitch hard if it sees this gem
group :test, :development do
	gem 'sqlite3'
end

gem 'will_paginate', '~> 3.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

# Heroku uses postgreSQL
group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-ui-rails'
gem "jquery-rails", "~> 2.3.0"
gem 'jquery-ui-themes'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
