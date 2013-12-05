source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# group :db do
  gem 'mysql2','0.3.11'
  gem 'kaminari'                        # pagination
  gem 'paperclip'                       # attachment tool
  gem 'ancestry'                        # Table Tree tool
# end

# group :addons do
  gem 'devise'                          # authentication
  gem 'cancan'                          # role management system
  gem 'inherited_resources'             # DRY for CRUD methods in controller
# end


# Gems used only for assets and not required
# in production environments by default.

group :production, :staging do
  gem 'unicorn'
  gem 'capistrano'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem "twitter-bootstrap-rails"
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-rails'
end

group :development do
  gem 'letter_opener'
  gem 'debugger'
end

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
