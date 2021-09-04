class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      enable_extension('citext')
      
      t.citext :title, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tags, [:title, :user_id], unique: true
  end
end
