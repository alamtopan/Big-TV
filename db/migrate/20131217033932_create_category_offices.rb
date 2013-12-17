class CreateCategoryOffices < ActiveRecord::Migration
  def up
    create_table :category_offices do |t|
      t.string      :name
      t.timestamp
    end
  end

  def down
    drop_table :category_offices
  end
end
