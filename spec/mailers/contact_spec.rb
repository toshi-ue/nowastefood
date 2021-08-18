require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  describe '#send_mail' do
    let(:contact) { create(:contact) }
    let(:mail)    { described_class.send_mail(contact).deliver_now }

    it "renders the headers" do
      expect(mail.subject).to include contact.subject
      expect(mail.to).to eq([ENV['TOMAIL']])
    end
  end
end
