class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.references :user, null: false
      t.references :post, null: false

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :post_id
  end
end
