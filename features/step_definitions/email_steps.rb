class Mailer < ActionMailer::Base
  default from: 'donotreply@example.com'
  def notify(options)
    mail to: options.fetch(:to), subject: options.fetch(:subject), body: options.fetch(:body)
  end
end

Given(/^a "(.*?)" email sent to "(.*?)" containing:$/) do |subject, recipient, body|
  mail = Mailer.notify(to: recipient, subject: subject, body: body)
  begin
    mail.deliver_now # ActionMailer >= 4.2
  rescue NoMethodError
    mail.deliver
  end
end
