class AddAudiofileToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :audiofile, :string
  end
end
