class AddUserRefToLikes < ActiveRecord::Migration[7.1]
  def change
    add_reference :likes, :user, null: false, foreign_key: true, index: true
  end
end
