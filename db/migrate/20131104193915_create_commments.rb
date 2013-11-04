class CreateCommments < ActiveRecord::Migration
  def change
    create_table :commments do |t|
      t.text :body
      t.references :post

      t.timestamps
    end
    add_index :commments, :post_id
  end
end
