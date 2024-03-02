class ChangeColumnTypeOfRounds < ActiveRecord::Migration[7.1]
  def change
    change_column :rounds, :crs, "integer USING CAST(crs AS integer)"
  end
end
