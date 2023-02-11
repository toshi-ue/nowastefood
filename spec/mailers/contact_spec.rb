# frozen_string_literal: true

require 'rails_helper'

# 現在使用しないためコメントアウト
# RSpec.describe ContactMailer, type: :mailer do
#   describe '#send_mail_master' do
#     let(:contact) { create(:contact) }
#     let(:mail)    { described_class.send_mail_master(contact).deliver_now }

#     it "renders the headers" do
#       expect(mail.subject).to include contact.subject
#       expect(mail.to.last).to eq(ENV['TOMAIL'])
#     end
#   end

#   describe '#send_mail_user' do
#     let(:contact) { create(:contact) }
#     let(:user) { create(:user) }
#     let(:mail) { described_class.send_mail_user(contact, user).deliver_now }

#     it "renders the headers" do
#       expect(mail.subject).to include '自動送信'
#       expect(mail.to.last).to eq(user.email)
#     end
#   end
# end
