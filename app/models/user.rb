# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :delete_all

  def self.login_with_oauth(auth)
    user = find_or_initialize_by(uid: auth.uid)
    user.uid = auth.uid
    user.avatar_url = auth.info.image
    user.provider = auth.provider
    user.email = auth.info.email
    user.name = auth.info.name
    user
  end
end
