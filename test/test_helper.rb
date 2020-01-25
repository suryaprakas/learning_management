ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'mocha/setup'
require 'test_unit_extensions'
require 'custom_headers'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def api_key_header
    {'X-API-KEY' => 'some_api_key'}
  end
end