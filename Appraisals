# Supported ActionMailer versions
actionmailer_versions = [
  '3.0.0', '3.1.0', '3.2.0',
  '4.0.0', '4.1.0', '4.2.0',
]
# Supported Capybara versions
capybara_versions = [
  '1.0.0',
  '2.4.0',
]

actionmailer_versions.product(capybara_versions).each do |actionmailer_version, capybara_version|
  appraise "actionmailer-#{actionmailer_version},capybara-#{capybara_version}" do
    gem 'actionmailer', actionmailer_version
    gem 'capybara', capybara_version
  end
end
