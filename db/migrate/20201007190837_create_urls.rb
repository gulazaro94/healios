class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :url
      t.string :token, index: true, limit: 10
      t.string :access_count, default: 0

      t.timestamps
    end
  end
end
