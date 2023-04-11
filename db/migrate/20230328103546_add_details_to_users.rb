class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :photo, :string, default: "https://img.freepik.com/free-icon/user_318-159711.jpg"
    add_column :users, :bio, :text
    add_column :users, :posts_counter, :integer
  end
end
