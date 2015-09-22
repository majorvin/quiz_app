class CreateCertificationTrackCategoriesJoinTable < ActiveRecord::Migration
  def change
    create_table :certification_tracks_categories do |t|
      t.references :category, null: false
      t.references :track, null: false
    end

    add_index :certification_tracks_categories, [:category_id, :track_id], name: "certification_tracks_categories_index"
  end
end
