require 'active_support'
require 'active_support/core_ext'
require "shoulda/matchers"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    # Choose one or more libraries:
    with.library :active_record
  end
end
