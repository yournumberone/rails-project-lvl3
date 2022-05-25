# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authenticate_user!
  before_action :admin_authenticate

  def admin_authenticate
    authorize current_user, :admin?
  end
end
