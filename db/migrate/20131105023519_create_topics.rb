class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.boolean :public, default: true
      t.text :description, null: false

      t.timestamps
    end
  end
end
