class AddQuestionCategories < ActiveRecord::Migration
  def change
    create_table :question_set_categories do |t|
      t.string :name, null: false, index: true
      t.boolean :enabled, null: false, default: false
      t.datetime :archived_at
      t.integer :max_question

      t.timestamps null: false
    end
  end
end
