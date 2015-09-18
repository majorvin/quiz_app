class AddGradeToExamList < ActiveRecord::Migration
  def change
    add_column :exam_lists, :grade, :decimal
  end
end
