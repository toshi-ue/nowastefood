# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def send_mail_master(contact)
    @contact = contact
    mail(
      to: ENV.fetch('TOMAIL', nil),
      subject: "【#{@contact.category_i18n}】 #{@contact.subject}"
    )
  end

  def send_mail_user(contact, user)
    @contact = contact
    mail(
      to: user.email,
      subject: '自動送信(お問い合わせ内容の確認)'
    )
  end
end
