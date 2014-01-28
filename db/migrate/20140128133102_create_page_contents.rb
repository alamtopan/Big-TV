class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.string :title
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
