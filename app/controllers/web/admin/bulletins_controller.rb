class Web::Admin::BulletinsController < Web::Admin::ApplicationController

  def index
    @bulletins = Bulletin.all
    authorize [:admin, @bulletins]
  end

end