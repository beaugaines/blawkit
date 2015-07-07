source 'https://rubygems.org'
# ruby version - to make Heroku happy
ruby '2.2.2'

gem 'rails', '3.2.16'
gem 'haml-rails'
gem 'pg'
gem 'devise'
gem 'cancan'

gem 'jquery-rails'
gem 'toastr-rails'
gem 'figaro'
gem 'redcarpet'
gem 'gravtastic'

# image upload
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'unf'

# pagination
gem 'will_paginate'
gem 'will_paginate-foundation'

# skip asset plugin injection on Heroku
gem 'rails_12factor'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'zurb-foundation'
  gem 'foundation-icons-sass-rails'
end

group :development do
  gem 'hirb'
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'quiet_assets'
end


# various
gem 'ffaker'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'should_not'
end

