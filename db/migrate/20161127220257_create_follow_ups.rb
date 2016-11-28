class CreateFollowUps < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_ups do |t|
      t.string :details
      t.string :updates
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end
  end
end
