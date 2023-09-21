class AddDescriptionToUsers < ActiveRecord::Migration[7.0]
  def change

    add_column :users, :bio, :strings
    add_column :users, :username, :strings

  end
end
