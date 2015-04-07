require 'email_test_helpers/version'
require 'action_mailer'
require 'capybara'

module EmailTestHelpers
  NotFound = Class.new(StandardError)

  def click_email_link(key = nil)
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
      link = Capybara.string(last_email_body).all('a').detect do |element|
        case key
        when Regexp then key === element.text || key === element[:href]
        when String then element.text.downcase.include?(key.downcase) || element[:href].include?(key)
        else raise TypeError, "key must be Regexp or String (was #{key.class.name})"
        end
      end
      if link
        link[:href]
      else
        raise(NotFound, "Couldn't find link with key: #{key}")
      end
    else
      Capybara.string(last_email_body).first('a')['href']
    end
  end

  def reset_last_email
    @last_email = nil
  end

  private

  def last_email
    @last_email || find_email
  end

  def last_email_body
    last_email.body.raw_source
  end
end
