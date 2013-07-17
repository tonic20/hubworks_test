class AddPermalinkToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :permalink, :string, limit: 1000
    add_index :posts, :permalink

    Post.reset_column_information
    Post.find_each do |p|
      p.generate_permalink
      p.save
    end
  end

  def down
    remove_column :posts, :permalink
  end
end