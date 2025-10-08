class CreateParents < ActiveRecord::Migration[7.2]
  def change
    create_table :parents do |t|
      t.timestamps
    end
  end
end
