class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      add_reference :users, foreign_key: true, index: true
      add_reference :posts, foreign_key: true, index: true
      t.timestamps
    end
  end
end
