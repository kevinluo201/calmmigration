class CreateLevelPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :level_plans do |t|
      t.integer :year
      t.integer :target
      t.string :source

      t.timestamps
    end
  end
end
