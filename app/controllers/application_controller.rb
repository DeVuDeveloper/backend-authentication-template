class ApplicationController < ActionController::Base
  include AuthenticateRequest
  before_action :current_user
end
