# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|

  # helper methods
  config.include FactoryGirl::Syntax::Methods
  #config.include Devise::TestHelpers, :type => :controller
  config.include UserHelper

  # defer GC
  config.before(:each) { GC.disable }
  config.after(:each) { GC.enable }

  # clean up db
  config.before(:each) do
    DatabaseCleaner.strategy = if example.metadata[:js]
      :truncation
    else
      :transaction
    end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # focus scenarios
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
