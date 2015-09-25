class AddTableCertificationTrakcs < ActiveRecord::Migration
  def change
    create_table :certification_tracks do |t|
      t.string :name, null: false
      t.boolean :enabled, default: false
      t.timestamps null: false
    end
  end
end
