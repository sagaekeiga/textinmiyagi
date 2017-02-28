class MailSenderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mail_sender_mailer.inquiry.subject
  #
  def inquiry(contact)
    @contact = contact

    mail to: "sagae5.28rujeae@gmail.com"
  end
end
