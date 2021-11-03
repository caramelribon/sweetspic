class RenameImgColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :img, :img_id
  end
end
