class Mailer < ActionMailer::Base
  default from: 'donotreply@example.com'
  def notify(to:, subject:, body:)
    mail to: to, subject: subject, body: body
  end
end

Given(/^a "(.*?)" email sent to "(.*?)" containing:$/) do |subject, recipient, body|
  Mailer.notify(to: recipient, subject: subject, body: body).deliver
end
