class ApplicationController < ActionController::API
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
end
