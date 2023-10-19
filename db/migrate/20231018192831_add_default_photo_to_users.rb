class AddDefaultPhotoToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :photo, :string,
      default: 'https://i.pinimg.com/474x/74/67/ac/7467acd73768ec753f20c4ac6cf39441.jpg'
  end
end
