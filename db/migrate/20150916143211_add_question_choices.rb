class AddQuestionChoices < ActiveRecord::Migration
  def change
    create_table :question_set_choices do |t|
      t.references :question, index: true, null: false
      t.boolean :answer, null: false, default: false
      t.string :text, null: false

      t.timestamps null: false
    end

    add_foreign_key :question_set_choices, :question_set_questions, column: 'question_id'
  end
end
