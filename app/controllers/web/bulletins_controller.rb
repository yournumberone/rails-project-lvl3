class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create update destroy]

  def index
    @bulletins = Bulletin.published.order(created_at: :desc)
  end

  def show
    @bulletin = set_bulletin
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = current_user.bulletins.new(bulletin_params)
    @bulletin.moderate
    if @bulletin.save
      redirect_to bulletin_path(@bulletin), notice: t('.success')
    else
      flash[:alert] = @bulletin.errors.first.full_message
      render :new
    end
  end

  def edit
    @bulletin = set_bulletin
  end

  def update
    bulletin = set_bulletin
    if bulletin.update(bulletin_params)
      redirect_to bulletin_path(bulletin), notice: t('.success')
    else
      flash[:alert] = bulletin.errors.first.full_message
      render :edit
    end
  end

  def destroy
    @bulletin = set_bulletin
  end

  def moderate
    bulletin = set_bulletin

    if bulletin.may_moderate?
      bulletin.moderate!
      redirect_to profile_path, notice: t('.success')
    else
      flash[:alert] = bulletin.errors.first.full_message
      redirect_to bulletin_path(bulletin)
    end
  end

  def archive
    bulletin = set_bulletin

    if bulletin.may_archive?
      bulletin.archive!
      redirect_to profile_path, notice: t('.success')
    else
      flash[:alert] = bulletin.errors.first.full_message
      redirect_to bulletin_path(bulletin)
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(%i[category_id title description image])
  end

  def set_bulletin
    Bulletin.find(params[:id])
  end
end
