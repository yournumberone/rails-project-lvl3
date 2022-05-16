# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc)
    @draft_bulletins = @bulletins.draft
    @under_moderation_bulletins = @bulletins.under_moderation
    @published_bulletins = @bulletins.published
    @rejected_bulletins = @bulletins.rejected
    @archived_bulletins = @bulletins.archived
  end
end
