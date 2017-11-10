class AddResetTokensToMailbox < ActiveRecord::Migration[5.0]
  def change
    add_column :mailboxes, :reset_token, :string, index: true
    add_column :mailboxes, :reset_token_generated_at, :datetime
  end
end
