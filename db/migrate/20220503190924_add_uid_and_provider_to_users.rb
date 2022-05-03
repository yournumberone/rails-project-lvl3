class AddUidAndProviderToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string, index: true
    add_column :users, :provider, :string, index: true
  end
end
