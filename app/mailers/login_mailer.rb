class LoginMailer < ApplicationMailer
  def login_mail(session,login_time)
   @session = session
   @time = login_time

   mail to: "#{@session.email}", subject: "ログインが完了しました"
  end
end
