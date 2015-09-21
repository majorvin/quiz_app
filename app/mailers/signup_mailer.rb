class SignupMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def send_notification(user)
    @user = user

    mail(to: "majorvin.tan@mosaic.com", subject: "New Registration for #{@user.first_name} #{@user.last_name}")
  end
end