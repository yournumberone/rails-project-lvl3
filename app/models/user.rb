class User < ApplicationRecord
  has_many :bulletins

  def self.login_with_omniauth(auth)
    user = find_or_initialize_by(uid: auth.uid)
    user.uid = auth.uid
    user.avatar_url = auth.info.image
    user.provider = auth.provider
    user.email = auth.info.email
    user.name = auth.info.name
    user
  end
end
