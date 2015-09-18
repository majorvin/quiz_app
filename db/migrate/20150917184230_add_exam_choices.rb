class AddExamChoices < ActiveRecord::Migration
  def change
    create_table :exam_choices do |t|
      t.references :question, null: false
      t.string :text, null: false
      t.boolean :answer, default: false
    end
  end
end
