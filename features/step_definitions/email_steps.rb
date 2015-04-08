class Mailer < ActionMailer::Base
  default from: 'donotreply@example.com'
  def notify(options)
    mail to: options.fetch(:to), subject: options.fetch(:subject), body: options.fetch(:body)
  end
end

def deliver_method
  supports_deliver_now = ActionMailer.version >= Gem::Version.new('4.2.0')
  supports_deliver_now ? :deliver_now : :deliver
end

Given(/^a "(.*?)" email sent to "(.*?)" containing:$/) do |subject, recipient, body|
  Mailer.notify(to: recipient, subject: subject, body: body).send deliver_method
end
