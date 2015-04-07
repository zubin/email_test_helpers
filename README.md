# EmailTestHelpers

Simple acceptance test helpers for emails

[![Build Status](https://travis-ci.org/zubin/email_test_helpers.svg)](https://travis-ci.org/zubin/email_test_helpers)
[![Gem Version](https://badge.fury.io/rb/email_test_helpers.svg)](http://badge.fury.io/rb/email_test_helpers)

## Features

* Find emails with optional criteria: recipient (to, cc, bcc), subject, body
* Click links in emails

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'email_test_helpers', group: :test
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install email_test_helpers

Load it in your test library of choice, eg:

    # spec/support/email_test_helpers.rb
    RSpec.configure do |config|
      config.include EmailTestHelpers
    end

    # features/support/email_test_helpers.rb
    World(EmailTestHelpers)

## Usage

Main methods are:

* `find_email`
  * returns the most recent email matching optional criteria
  * raises NotFound when no matches
  * optional criteria:
    * to (email address)
    * cc (email address)
    * bcc (email address)
    * subject (string: exact match; or regexp)
* `click_email_link`
  * follows first link matching optional argument
  * in most recently found email or last sent email when no previous searches
  * argument can be URL or link text
  * argument can be string (exact match) or regexp

For example, to assert an email confirmation was sent and click the confirmation link:

    find_email to: @current_user.email, subject: /confirm/i
    click_email_link /confirm/i

See `spec/email_test_helpers_spec.rb` for more details.

## Licence

MIT Licence

(c) 2015 Zubin Henner
