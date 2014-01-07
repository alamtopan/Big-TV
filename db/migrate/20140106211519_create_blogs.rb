class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.string :author
      t.timestamps
    end
    add_attachment  :blogs, :picture
  end
end


