class AddAvatarBgColorToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :avatar_bg_color, :string, null: false
  end
end
