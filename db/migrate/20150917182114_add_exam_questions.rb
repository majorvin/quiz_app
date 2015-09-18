class AddExamQuestions < ActiveRecord::Migration
  def change
    create_table :exam_questions do |t|
      t.references :list, index: true, null: false
      t.references :question_set_question, null: false
      t.string :value
      t.string :text, null: false
    end
  end
end
