class AddUsernameDevise < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
  end

end
