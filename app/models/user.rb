class User < ApplicationRecord
  has_secure_token

  after_create :send_confirm_email
  def send_confirm_email
    return if confirmed?

    verification = UserVerification.create(user_id: id, verify_type: :confirm_email)
    Rails.application.routes.url_helpers.auth_confirm_email_url(host: 'localhost:3000', token: verification.token)
    # ADD Email Job with `url` added in "CONFIRM EMAIL" button
  end
end
