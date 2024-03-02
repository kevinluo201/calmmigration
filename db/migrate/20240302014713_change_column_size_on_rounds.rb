class ChangeColumnSizeOnRounds < ActiveRecord::Migration[7.1]
  def change
    change_column :rounds, :size, "integer USING CAST(REPLACE(size, ',', '') AS integer)"
  end
end
