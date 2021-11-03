class RenameImgIdColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :img_id, :img
  end
end
