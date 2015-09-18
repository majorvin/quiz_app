class AddWorkFlowStateToExamList < ActiveRecord::Migration
  def change
    add_column :exam_lists, :workflow_state, :string
  end
end
