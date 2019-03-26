class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :event_url
      t.datetime :start_date
      t.datetime :end_date
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :events, [:user_id, :created_at]
  end
end
