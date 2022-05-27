class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :word_count
      t.belongs_to :user

      t.timestamps
    end
  end
end
