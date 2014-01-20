source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', git: 'git://github.com/rails/rails.git'

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
  gem 'enumerize'                       # Enumerated attributes with I18n
  gem 'cocoon'                          # Dynamic nested forms using jQuery
  gem 'delayed_job_active_record'       # Background Job Tools
  gem 'daemons'                         # Daemon for Background Job
  gem 'delayed_job_web'                 # Delayed Job Monitoring System
  gem 'figaro'
  gem "recaptcha", require: "recaptcha/rails"
  gem "exception_notification", :require => "exception_notifier"
  gem 'remotipart', '~> 1.2'
  gem 'acts_as_list'
#end


# Gems used only for assets and not required
# in production environments by default.

group :production, :staging do
  gem 'unicorn'

end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', platforms: :ruby
  gem 'turbo-sprockets-rails3'
  gem "twitter-bootstrap-rails"
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-rails'
end

group :development, :test do
  gem 'letter_opener'
  gem 'debugger'
  gem 'quiet_assets'

  gem 'capistrano', '~> 2'
end
