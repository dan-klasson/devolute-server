class RegistrationsController < ApplicationController
  skip_before_action :authorize_request, only: [:create]

  def create
    json_response UserSignup.run(params)
  end
end
