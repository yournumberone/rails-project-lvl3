# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController

  def index
    authorize [:admin, Bulletin]
    @bulletins = Bulletin.order(created_at: :desc).includes(:user)
    @under_moderation_bulletins = @bulletins.under_moderation
    @archived_bulletins = @bulletins.archived
  end

  def reject
    bulletin = Bulletin.find(params[:id])
    authorize [:admin, bulletin]
    if bulletin.may_reject?
      bulletin.reject!
      redirect_to admin_bulletins_path, notice: t('.success')
    else
      flash[:alert] = bulletin.errors.first.full_message
      redirect_to admin_bulletins_path
    end
  end

  def publish
    bulletin = Bulletin.find(params[:id])
    authorize [:admin, bulletin]
    if bulletin.may_publish?
      bulletin.publish!
      redirect_to admin_bulletins_path, notice: t('.success')
    else
      flash[:alert] = bulletin.errors.first.full_message
      redirect_to admin_bulletins_path
    end
  end

  def archive
    bulletin = Bulletin.find(params[:id])
    authorize [:admin, bulletin]
    if bulletin.may_archive?
      bulletin.archive!
      redirect_to admin_bulletins_path, notice: t('.success')
    else
      flash[:alert] = bulletin.errors.first.full_message
      redirect_to admin_bulletins_path
    end
  end
end
