class RemoveNonUniqueIndexAndAddUniqueIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :posts, :author_id
    add_index :posts, :author_id, unique: true

    remove_index :comments, :user_id
    add_index :comments, :user_id, unique: true

    remove_index :comments, :post_id
    add_index :comments, :post_id, unique: true

    remove_index :likes, :user_id
    add_index :likes, :user_id, unique: true

    remove_index :likes, :post_id
    add_index :likes, :post_id, unique: true
  end
end
