class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.integer :user_id
      t.string :long_url, null:false
      t.string :short_url
    end
    add_index :shortened_urls, :short_url, unique: true
  end
end
