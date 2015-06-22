require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'support/test_password_helper'

# Minitest reporter configuration
reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use!(
  Minitest::Reporters::DefaultReporter.new(reporter_options),
  ENV,
  Minitest.backtrace_filter)

module ActiveSupport
  # Configuration for our tests
  class TestCase
    ActiveRecord::Migration.check_pending!

    # Setup all fixtures in test/fixtures/*.yml for all tests in
    # alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include TestPasswordHelper
    ActiveRecord::FixtureSet.context_class.send :include, TestPasswordHelper
  end
end
