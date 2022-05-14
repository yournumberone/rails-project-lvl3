class Web::ProfileController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @draft_bulletins = current_user.bulletins.draft
  end
end