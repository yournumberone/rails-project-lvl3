class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create update destroy]

  def index
    @bulletins = Bulletin.order(:desc)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = current_user.bulletins.new(bulletin_params)
    if @bulletin.save
      redirect_to bulletin_path(@bulletin), notice: t('.success')
    else
      flash[:alert] = @bulletin.errors.first.full_message
      render :new
    end
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  def update
    @bulletin = Bulletin.find(params[:id])
  end

  def destroy
    @bulletin = Bulletin.find(params[:id])
  end

  private

  def bulletin_params
    params.require(:bulletin).permit([:category_id, :title, :description, :image])
  end
end
