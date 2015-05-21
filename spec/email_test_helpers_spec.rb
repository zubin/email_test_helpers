require 'spec_helper'

describe EmailTestHelpers do
  include EmailTestHelpers
  after { reset_last_email }

  describe '::VERSION' do
    it 'has a version number' do
      expect(EmailTestHelpers::VERSION).not_to be_nil
    end
  end

  describe '#click_email_link' do
    it "visits email link" do
      key, link = double, double
      allow(self).to receive(:find_email_link).with(key).and_return(link)
      expect(self).to receive(:visit).with(link)
      click_email_link(key)
    end

    it "doesn't require key" do
      link = double
      allow(self).to receive(:find_email_link).with(nil).and_return(link)
      expect(self).to receive(:visit).with(link)
      click_email_link
    end
  end

  describe '#emails' do
    it "returns delivered mail" do
      deliveries = double
      allow(ActionMailer::Base).to receive(:deliveries).and_return(deliveries)
      expect(emails).to eq(deliveries)
    end
  end

  describe '#find_email' do
    let(:first_email) do
      double(
        to:      ['first recipient'],
        cc:      ['first cc'],
        bcc:     ['first bcc'],
        subject: "first subject",
        body:    double(raw_source: "first body message"),
      )
    end
    let(:last_email)  do
      double(
        to:      ['last recipient'],
        cc:      ['last cc'],
        bcc:     ['last bcc'],
        subject: "last subject",
        body:    double(raw_source: "last body message"),
        parts:   [], # testing multipart in features
      )
    end
    before { allow(self).to receive(:emails).and_return([first_email, last_email]) }

    context "when no args" do
      it "returns last email" do
        expect(find_email).to eq(last_email)
      end

      it "sets @last_email" do
        expect { find_email }.to change { instance_variable_get('@last_email') }.to(last_email)
      end
    end

    context "when searching by recipients" do
      it "returns matching email (to)" do
        expect(find_email(to: 'first recipient')).to eq(first_email)
      end

      it "returns matching email (cc)" do
        expect(find_email(cc: 'first cc')).to eq(first_email)
      end

      it "returns matching email (bcc)" do
        expect(find_email(bcc: 'first bcc')).to eq(first_email)
      end
    end

    context "when searching by subject (string)" do
      it "returns matching email" do
        expect(find_email(subject: 'first subject')).to eq(first_email)
      end
    end

    context "when searching by subject (regexp)" do
      it "returns matching email" do
        expect(find_email(subject: /first/)).to eq(first_email)
      end
    end

    context "when not found" do
      it "raises NotFound" do
        expect { find_email(to: 'missing') }.to raise_error(EmailTestHelpers::NotFound)
      end
    end

    context "when searching by body (regexp)" do
      it "returns matching email" do
        expect(find_email(body: /first body/i)).to eq(first_email)
      end
    end

    context "when invalid option" do
      it "raises ArgumentError" do
        expect do
          find_email(foo: 'bar')
        end.to raise_error(ArgumentError, "Invalid options detected: foo")
      end
    end
  end

  describe '#find_email_link' do
    let(:email_body) do
      <<-HTML
      <p>Some text</p>
      <a href="http://first-link">This is link #1</a>
      <a href="http://second-link">This is link #2</a>
      HTML
    end
    let(:last_email) { double(body: double(raw_source: email_body)) }

    before { allow(self).to receive(:last_email).and_return(last_email) }

    context "with no args" do
      it "returns first link" do
        expect(find_email_link).to eq('http://first-link')
      end
    end

    context "with URL arg" do
      it "finds matching link" do
        expect(find_email_link('second')).to eq('http://second-link')
      end
    end

    context "with link text arg" do
      it "finds matching link" do
        expect(find_email_link('link #2')).to eq('http://second-link')
      end
    end

    context "with regexp" do
      it "finds matching link" do
        expect(find_email_link(/2/)).to eq('http://second-link')
      end
    end

    context "with unhandled type" do
      it "raises TypeError" do
        expect do
          find_email_link(:second)
        end.to raise_error(TypeError, "key must be Regexp or String (was Symbol)")
      end
    end

    context "when no matches" do
      it "raises NotFound" do
        expect { find_email_link('missing') }.to raise_error(EmailTestHelpers::NotFound)
      end
    end
  end

  describe '#last_email' do
    context "when @last_email set" do
      it "returns @last_email" do
        @last_email = double
        expect(last_email).to eq(@last_email)
      end
    end

    context "when @last_email not set" do
      it "falls back to most recently sent email" do
        last_email = double
        allow(self).to receive(:find_email).with(no_args).and_return(last_email)
        expect(last_email).to eq(last_email)
      end
    end
  end
end
