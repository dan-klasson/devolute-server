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
    @current_user = AuthorizeRequest.run(request.instance_values).result
    response_hash = { success: false, errors: { auth: 'Not Authorized' } }
    render json: response_hash, status: 401 unless @current_user
  end
end
