# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @tabs_array = %w[all under_moderation draft published rejected archived]
    @active_tab = params[:tab] || 'all'

    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page]).per(15).send(@active_tab)
  end
end
