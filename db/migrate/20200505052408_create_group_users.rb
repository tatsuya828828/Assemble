class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.references :group, foreign_key: true
      t.references :user,  foreign_key: true
      t.integer :join_status

      t.timestamps
    end
  end
end
