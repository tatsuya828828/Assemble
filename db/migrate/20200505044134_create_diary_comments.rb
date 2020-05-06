class CreateDiaryComments < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_comments do |t|
      t.references :user, foreign_key: true
      t.references :diary, foreign_key: true
      t.string :comment, null: false

      t.timestamps
    end
  end
end
