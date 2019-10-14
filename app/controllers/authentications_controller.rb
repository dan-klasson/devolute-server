class AuthenticationsController < ApplicationController
  skip_before_action :authorize_request, only: [:create]

  def create
    json_response UserLogin.run(params)
  end
end
