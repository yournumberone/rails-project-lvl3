# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy to_moderate archive]

  def index
    @q = Bulletin.published.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).includes(:category).page(params[:page])
  end

  def show
    @bulletin = find_bulletin
    authorize @bulletin
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = current_user.bulletins.new(bulletin_params)
    if @bulletin.save
      redirect_to bulletin_path(@bulletin), notice: t('.success')
    else
      render :new
    end
  end

  def edit
    @bulletin = find_bulletin
    authorize @bulletin
  end

  def update
    @bulletin = find_bulletin
    authorize @bulletin
    if @bulletin.update(bulletin_params)
      redirect_to bulletin_path(@bulletin), notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @bulletin = find_bulletin
    authorize @bulletin
    if @bulletin.destroy
      redirect_to profile_path, notice: t('.success')
    else
      redirect_to profile_path, alert: t('.fail')
    end
  end

  def to_moderate
    @bulletin = find_bulletin
    authorize @bulletin
    if @bulletin.may_moderate?
      @bulletin.moderate!
      redirect_to profile_path, notice: t('.success')
    else
      flash[:alert] = t('.fail')
      redirect_to bulletin_path(@bulletin)
    end
  end

  def archive
    @bulletin = find_bulletin
    authorize @bulletin
    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_to profile_path, notice: t('.success')
    else
      flash[:alert] = t('.fail')
      redirect_to bulletin_path(@bulletin)
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(%i[category_id title description image])
  end

  def find_bulletin
    Bulletin.find(params[:id])
  end
end
