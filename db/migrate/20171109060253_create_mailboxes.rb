class CreateMailboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :mailboxes do |t|
      t.string :email, index: true
      t.string :access_token, index: true
      t.string :api_key, index: true

      t.timestamps
    end
  end
end
