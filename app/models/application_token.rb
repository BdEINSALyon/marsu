class ApplicationToken < ApplicationRecord
  belongs_to :application

  scope :currently_valid, -> {where('expiration > ?', DateTime.now)}

  def self.for_application(app)
    if app.application_tokens.currently_valid.length > 0
      app.application_tokens.currently_valid.first
    else
      ApplicationToken.create application: app, expiration: 2.days.since, token: Devise.friendly_token(40)
    end
  end

end
