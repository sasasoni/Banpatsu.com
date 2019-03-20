class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    # サークル紹介文
    add_column :users, :profile, :text
    add_column :users, :twitter_name, :string
    add_column :users, :site_url, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
