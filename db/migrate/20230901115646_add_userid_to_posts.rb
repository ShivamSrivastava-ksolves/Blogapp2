class AddUseridToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :userid, :string
  end
end
