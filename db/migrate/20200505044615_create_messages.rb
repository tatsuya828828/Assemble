class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user,    foreign_key: true
      t.references :group, 	 foreign_key: true
      t.string 	   :content, null: false

      t.timestamps
    end
  end
end
