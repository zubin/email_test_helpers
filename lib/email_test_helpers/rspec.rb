require 'email_test_helpers'

RSpec.configure do |config|
  config.include EmailTestHelpers, type: [:feature, :request]
end
