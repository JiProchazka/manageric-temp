class Api::ApiController < ApplicationController

  protected

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      User.token_exists? token
    end
  end
end
