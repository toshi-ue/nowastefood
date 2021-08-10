class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail(
      to: ENV['TOMAIL'],
      subject: "【#{@contact.category_i18n}】 #{@contact.subject}"
    )
  end
end
