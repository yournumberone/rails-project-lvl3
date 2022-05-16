# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.login_with_oauth(auth)
    if user.save
      sign_in(user)
      redirect_to root_path, notice: t('welcome', name: user.name)
    else
      redirect_to root_path, alert: t('oops')
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: t('see_you')
  end
end
