class CreateChildren < ActiveRecord::Migration[7.2]
  def change
    create_table :children do |t|
      t.timestamps
    end
  end
end
