class CreateJoinTableParentsChildren < ActiveRecord::Migration[7.2]
  def change
    create_join_table :parents, :children do |t|
      # t.index [:parent_id, :child_id]
      # t.index [:child_id, :parent_id]
    end
  end
end
