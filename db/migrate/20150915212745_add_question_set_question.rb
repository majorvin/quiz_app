class AddQuestionSetQuestion < ActiveRecord::Migration
  def change
    create_table :question_set_questions do |t|
      t.references :category, index: true, null: false
      t.string :text, null: false, index: true
      t.datetime :archived_at

      t.timestamps null: false
    end

    add_foreign_key :question_set_questions, :question_set_categories, column: 'category_id'
  end
end
