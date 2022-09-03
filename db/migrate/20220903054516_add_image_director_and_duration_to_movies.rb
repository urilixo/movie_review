class AddImageDirectorAndDurationToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :image_file_name, :string, default: "placeholder.png"
    add_column :movies, :director, :string
    add_column :movies, :duration, :integer, default: 90
  end
end
