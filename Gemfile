# you are using Ruby 1.9.3, better to 2.0.0 upgrade for more speed

source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '>=4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'
gem 'pg'
gem 'simple_form'
gem 'factory_girl_rails'
gem "bcrypt-ruby", :require => "bcrypt"
# The asset_sync gem is WELL worth using
# but you should read more about it before deciding
# https://github.com/rumblelabs/asset_sync
# gem 'asset_sync'

# only want sqlite in dev and test envs
group :development, :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
end

group :test do
  gem 'capybara'
end

group :production do
  gem 'unicorn' # make sure you follow installation instructions for this gem
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', require: false
end