# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def welcome_email
    # Set up a temporary user for the preview
    user = User.new(email: "joe@gmail.com")

    UserMailer.with(user: user).welcome_email
  end

end
