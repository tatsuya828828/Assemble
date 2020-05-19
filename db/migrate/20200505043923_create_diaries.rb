class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.references :user,    foreign_key: true
      t.references :group,   foreign_key: true
      t.string     :image
      t.string     :title,   null: false
      t.text       :body,    null: false
      t.integer    :private_status

      t.timestamps
    end
  end
end
