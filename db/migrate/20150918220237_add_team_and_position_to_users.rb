class AddTeamAndPositionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :team, :string
    add_column :users, :position, :string
  end
end
