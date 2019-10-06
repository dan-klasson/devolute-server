class AuthorizeRequest < Mutations::Command
  required do
    hash :headers
  end

  def execute
    user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    user || errors.add(:token, 'Invalid token') && nil
  end

  private

  def decoded_auth_token
    JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    authorization = headers['Authorization']
    return authorization.split(' ').last if authorization.present?

    errors.add(:token, 'Missing token')
    nil
  end
end
