Then(/^`(.*)` finds "(.*?)" email$/) do |code, subject|
  mail = eval(code)
  expect(mail.subject).to eq(subject)
end

Then(/^`(.*)` raises "(.*?)"$/) do |code, exception|
  expect { eval code }.to raise_error(exception.constantize)
end

Then(/^`(.*)` visits "(.*?)"$/) do |code, url|
  expect(self).to receive(:visit).with(url)
  eval code
end
