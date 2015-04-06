require 'spec_helper'

describe EmailTestHelpers do
  include EmailTestHelpers

  before { ActionMailer::Base.delivery_method = :test }

  class Mailer < ActionMailer::Base
   default from: 'donotreply@example.com'

    def welcome
      mail to: 'someone@example.com', subject: "Welcome", body: <<-HTML
      <p>
        Hello and <a href="http://the-link">welcome</a>!
      </p>
      HTML
    end
  end

  context "with welcome email" do
    before { Mailer.welcome.deliver }

    it "supports clicking email links" do
      expect(self).to receive(:visit).with('http://the-link')
      click_email_link('welcome')
    end
  end
end
