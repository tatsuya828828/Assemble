class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string 	:name, null: false
      t.integer :leader
      t.string 	:self_id
      t.string  :image
      t.integer :private_status

      t.timestamps
    end

    add_index :groups, :self_id, unique: true
  end
end
