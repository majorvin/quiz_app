class AddCompletedAtToExamList < ActiveRecord::Migration
  def change
    add_column :exam_lists, :completed_at, :datetime
  end
end
