class AddUserRefToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :user, null: false, foreign_key: true, index: true
  end
end
