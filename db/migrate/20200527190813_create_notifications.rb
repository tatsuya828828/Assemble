class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :creator_id,        foreign_key: true
      t.integer :confirmer_id,      foreign_key: true
      t.references :group_user,     foreign_key: true
      t.references :group,          foreign_key: true
      t.references :friend,         foreign_key: true
      t.references :diary,          foreign_key: true
      t.references :diary_comment,  foreign_key: true
      t.references :direct_message, foreign_key: true
      t.references :room,           foreign_key: true
      t.references :message,        foreign_key: true
      t.references :memo,           foreign_key: true
      t.integer :confirm_status

      t.timestamps
    end
  end
end
