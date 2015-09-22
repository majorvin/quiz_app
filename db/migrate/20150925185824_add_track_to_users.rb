class AddTrackToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :track, index: true
  end
end
