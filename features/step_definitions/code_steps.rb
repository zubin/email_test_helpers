Then(/^"(.*?)" should find "(.*?)" email$/) do |code, subject|
  if subject.blank?
    expect { eval(code) }.to raise_error(EmailTestHelpers::NotFound)
  else
    mail = eval(code)
    expect(mail.subject).to eq(subject)
  end
end

Then(/^"(.*?)" should visit "(.*?)"$/) do |code, url|
  expect(self).to receive(:visit).with(url)
  eval code
end
