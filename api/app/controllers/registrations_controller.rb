class RegistrationsController < ApplicationController
  def create
    json_response UserSignup.run(params)
  end
end
