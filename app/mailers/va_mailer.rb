class VaMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.va_mailer.va.subject
  #
  def va(student)
    @student = student
    mail to: @student.email, from: 'BdE INSA Lyon <orgaif@mail.adhesion.bde-insa-lyon.fr>', reply_to: 'contact@bde-insa-lyon.fr', subject: "#{@student.first_name}, (re)découvre ta carte VA…"
  end
end
