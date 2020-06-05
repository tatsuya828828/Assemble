class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.references :user,            foreign_key: true
      t.string     :title
      t.text       :body
      t.integer    :confirm_status,  default: 0
      t.integer    :response_status, default: 0
      t.text       :reply


      t.timestamps
    end
  end
end
