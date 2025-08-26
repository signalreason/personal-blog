class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :body_md
      t.text :body_html
      t.text :summary
      t.string :status
      t.datetime :published_at

      t.timestamps
    end
  end
end
