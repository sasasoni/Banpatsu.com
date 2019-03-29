class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :circle_name
    add_index :events, :updated_at
    add_index :events, :title
    #Ex:- add_index("admin_users", "username")
  end
end
