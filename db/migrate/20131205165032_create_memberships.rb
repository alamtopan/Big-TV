class CreateMemberships < ActiveRecord::Migration
  def up
    create_table :memberships, force: true do |t|
      t.string     :name,         null: false, unique: true
      t.string     :slug
      t.text       :description
      t.date       :publish_on
      t.date       :expire_on
      t.integer    :version,      default: 0
      t.integer    :position,     default: 0
      t.boolean    :is_published, default: false
      t.boolean    :is_featured,  default: false
      t.datetime   :published_at
      t.datetime   :deleted_at
      t.timestamps
    end

    add_index :memberships, ["title", "version"]
    add_index :memberships, :slug, unique: true
  end

  def down
    drop_table :memberships
  end
end
