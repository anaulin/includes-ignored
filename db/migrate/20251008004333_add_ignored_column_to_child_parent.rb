class AddIgnoredColumnToChildParent < ActiveRecord::Migration[7.2]
  def change
    add_column :children_parents, :ignored, :integer, default: nil
  end
end
