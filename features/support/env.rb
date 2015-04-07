require 'cucumber/rspec/doubles'
require_relative '../../lib/email_test_helpers'

ActionMailer::Base.delivery_method = :test 
World(EmailTestHelpers)
Before { reset_last_email }
