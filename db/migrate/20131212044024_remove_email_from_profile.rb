class RemoveEmailFromProfile < ActiveRecord::Migration
  def up
    remove_column :profiles, :email
  end

  def down
    add_column :profiles, :email, :string
  end
end
