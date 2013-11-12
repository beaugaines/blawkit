class AddViewCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :view_count, :integer, null: false, default: 0
  end
end
