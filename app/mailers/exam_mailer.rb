class ExamMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def send_result(exam)
    @user = exam.user
    @category = exam.category
    @exam = exam

    mail(to: "majorvin.tan@mosaic.com", subject: "#{@user.first_name} #{@user.last_name} score for #{@category.name}")
  end
end