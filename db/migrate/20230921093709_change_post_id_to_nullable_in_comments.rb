class ChangePostIdToNullableInComments < ActiveRecord::Migration[7.0]
  def change
    change_column :comments, :post_id, :integer, null: true
  end
end
