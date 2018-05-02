class UserNotifierMailer < ApplicationMailer
  default :from => 'seamoscolombia@gmail.com'

# send a signup email to the user, pass in the user object that contains the user's email address
  def send_subscription_email(email, unsubscribe)
    @email = email
    @unsubscribe = unsubscribe
    mail( :to => email,
    :subject => 'Ahora estas suscrito al newsletter de SeamOS' )
  end

  def send_general_message(message)
    @message = message
    mail( to: 'yonnyquiceno@gmail.com', subject: message[:subject], content: message[:content] )
  end
end