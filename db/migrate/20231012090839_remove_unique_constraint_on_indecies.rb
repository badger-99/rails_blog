class RemoveUniqueConstraintOnIndecies < ActiveRecord::Migration[7.1]
  def change
    remove_index :posts, :author_id, unique: true
    add_index :posts, :author_id

    remove_index :comments, :user_id, unique: true
    add_index :comments, :user_id

    remove_index :comments, :post_id, unique: true
    add_index :comments, :post_id

    remove_index :likes, :user_id, unique: true
    add_index :likes, :user_id

    remove_index :likes, :post_id, unique: true
    add_index :likes, :post_id
  end
end
