class AddStateToBulletins < ActiveRecord::Migration[6.1]
  def change
    add_column :bulletins, :state, :string, default: 'draft'
  end
end
