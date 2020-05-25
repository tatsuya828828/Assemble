class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.string	   :content
      t.timestamps
    end
  end
end
