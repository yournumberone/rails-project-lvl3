class Web::ApplicationController < ApplicationController
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = t('permission_denied')
    redirect_back(fallback_location: root_path)
  end
end