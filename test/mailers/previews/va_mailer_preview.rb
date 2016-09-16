# Preview all emails at http://localhost:3000/rails/mailers/va_mailer
class VaMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/va_mailer/va
  def va
    VaMailer.va
  end

end
