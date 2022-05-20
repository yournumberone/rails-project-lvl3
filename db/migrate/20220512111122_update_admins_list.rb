class UpdateAdminsList < ActiveRecord::Migration[6.1]
  def change
    User.find_by(email: 'mars.shamgulov@gmail.com').try(:update, { admin: true })
  end
end
