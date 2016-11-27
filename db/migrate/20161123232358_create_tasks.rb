class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :details
      t.integer :user_created_id
      t.integer :user_attributed_id
      t.integer :priority
      t.integer :project_id
      t.integer :status, default: 0
      t.integer :stage, default: 0
      t.date :init_date
      t.date :expected_completion_date
      t.date :completion_date
      t.integer :code

      t.timestamps
    end
  end
end
