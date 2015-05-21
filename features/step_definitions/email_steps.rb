class Mailer < ActionMailer::Base
  default from: 'donotreply@example.com'
  self.view_paths = File.expand_path('../../views', __FILE__)

  def notify(options)
    @html = options.fetch(:body).html_safe
    case options.fetch(:delivery_type)
    when 'html'
      mail to: options.fetch(:to), subject: options.fetch(:subject), body: @html
    when 'multipart'
      mail to: options.fetch(:to), subject: options.fetch(:subject)
    else
      raise NotImplemented, options[:delivery_type]
    end
  end
end

Given(/^emails are sent with "(.*?)"$/) do |delivery_type|
  @delivery_type = delivery_type
end

Given(/^a "(.*?)" email sent to "(.*?)" containing:$/) do |subject, recipient, body|
  mail = Mailer.notify(to: recipient, subject: subject, body: body, delivery_type: @delivery_type)
  if mail.respond_to?(:deliver_now) # ActionMailer >= 4.2
    mail.deliver_now
  else
    mail.deliver
  end
end
