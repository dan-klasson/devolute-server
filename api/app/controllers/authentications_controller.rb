class AuthenticationsController < ApplicationController
  def create
    json_response UserLogin.run(params)
  end
end
