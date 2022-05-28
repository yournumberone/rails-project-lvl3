# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @tabs_array = %w[all under_moderation draft published rejected archived]
    @active_tab = params[:tab] || 'all'

    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).includes(:user).page(params[:page]).send(@active_tab)
  end

  def reject
    bulletin = Bulletin.find(params[:id])
    if bulletin.may_reject?
      bulletin.reject!
      redirect_to admin_bulletins_path, notice: t('.success')
    else
      flash[:alert] = t('.fail')
      redirect_to bulletin_path(bulletin)
    end
  end

  def publish
    bulletin = Bulletin.find(params[:id])
    if bulletin.may_publish?
      bulletin.publish!
      redirect_to admin_bulletins_path, notice: t('.success')
    else
      flash[:alert] = t('.fail')
      redirect_to bulletin_path(bulletin)
    end
  end

  def archive
    bulletin = Bulletin.find(params[:id])
    if bulletin.may_archive?
      bulletin.archive!
      redirect_to admin_bulletins_path, notice: t('.success')
    else
      flash[:alert] = t('.fail')
      redirect_to bulletin_path(bulletin)
    end
  end
end
