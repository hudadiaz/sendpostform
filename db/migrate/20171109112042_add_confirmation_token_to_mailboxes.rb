class AddConfirmationTokenToMailboxes < ActiveRecord::Migration[5.0]
  def change
    add_column :mailboxes, :confirmation_token, :string, index: true
    add_column :mailboxes, :confirmed_at, :datetime
  end
end
