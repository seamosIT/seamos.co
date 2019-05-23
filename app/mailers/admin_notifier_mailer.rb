class AdminNotifierMailer < ApplicationMailer
  default :from => 'contacto@seamos.co'

  def send_subscription_email(email, unsubscribe)
    @email = email
    @unsubscribe = unsubscribe
    mail( :to => email,
    :subject => 'Ahora estas suscrito al newsletter de SeamOS Buenaventura' )
  end

  def new_poll_created(poll, author, receiver)
    subject = "#{author.names} ha creado una nueva propuesta"
    @poll = poll
    @author = author
    @user = receiver
    mail( from: "SeamOS Democracia Digital <contacto@seamos.co>", to: receiver.email, subject: subject )
  end
end
