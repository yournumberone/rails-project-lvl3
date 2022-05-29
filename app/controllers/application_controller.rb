# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  helper_method :current_user, :signed_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = t('permission_denied')
    redirect_back(fallback_location: root_path)
  end

  protected

  def get_query(cookie_key)
    cookies.delete(cookie_key) if params[:clear]
    cookies[cookie_key] = params[:q].to_json if params[:q]
    @query = params[:q] || JSON.parse(cookies[cookie_key]) if cookies[cookie_key]
  end
end
