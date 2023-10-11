class AddPostRefToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :post, null: false, foreign_key: true, index: true
  end
end
