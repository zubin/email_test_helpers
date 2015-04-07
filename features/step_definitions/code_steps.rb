Then(/^`(.*)` visits "(.*?)"$/) do |code, url|
  expect(self).to receive(:visit).with(url)
  eval code
end
