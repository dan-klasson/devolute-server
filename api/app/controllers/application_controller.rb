class ApplicationController < ActionController::API
  before_action :authorize_request
  attr_reader :current_user

  private

  # override strong params
  def params
    request.parameters
  end

  def json_response(outcome)
    if outcome.success?
      render json: { success: true, result: outcome.result }, status: 200
    else
      errors = outcome.errors.message
      render json: { success: false, errors: errors }, status: 422
    end
  end

  def authorize_request
    outcome = AuthorizeRequest.run(token: request.headers['Authorization'])
    if outcome.success?
      @current_user = outcome.result
    else
      response_hash = { success: false, errors: outcome.errors.message }
      render json: response_hash, status: 401
    end
  end
end
