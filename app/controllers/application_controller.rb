# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Web::Authentication
  helper_method :current_user, :signed_in?
end
