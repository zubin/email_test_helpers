require 'email_test_helpers/version'
require 'action_mailer'
require 'capybara'

module EmailTestHelpers
  NotFound = Class.new(StandardError)

  def click_email_link(key)
    visit find_email_link(key)
  end

  def emails
    ActionMailer::Base.deliveries
  end

  def find_email(options = {})
    @last_email = emails.reverse.detect do |mail|
      [
        options[:to].nil?      || mail.to.include?(options[:to]),
        options[:cc].nil?      || mail.cc.include?(options[:cc]),
        options[:bcc].nil?     || mail.bcc.include?(options[:bcc]),
        options[:subject].nil? || options[:subject] === mail.subject,
      ].all?
    end or raise(NotFound, "Couldn't find email with options: #{options.inspect}")
  end

  def find_email_link(key = nil)
    if key
      e = Capybara.string(last_email_body).first("a[href*='#{key}']") ||
          Capybara.string(last_email_body).first("a", text: key) or
          raise(NotFound, "Couldn't find link with key: #{key}")
      e['href']
    else
      Capybara.string(last_email_body).first('a')['href']
    end
  end

  private

  def last_email
    @last_email || find_email
  end

  def last_email_body
    last_email.body.raw_source
  end
end
