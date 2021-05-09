class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.string :address
      t.string :content
      t.string :price
      t.string :photo
      t.string :stock
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
