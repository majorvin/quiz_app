class CreateExamList < ActiveRecord::Migration
  def change
    create_table :exam_lists do |t|
      t.references :category, index: true, null: false
      t.references :user, index: true, null: false
    end
  end
end
