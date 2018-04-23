class AuthToken
  def self.key
    Rails.application.credentials.secret_key_base
  end

  def self.sign(user)
    payload = { user_id: user.id }
    JsonWebToken.sign(payload, key: key)
  end

  def self.verify(token)
    result = JsonWebToken.verify(token, key: key)
    return nil if result[:error]

    result[:ok][:user_id]
  end
end