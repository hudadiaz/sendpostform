class AddMagicTokensToMailbox < ActiveRecord::Migration[5.0]
  def change
    add_column :mailboxes, :magic_token, :string, index: true
    add_column :mailboxes, :magic_token_generated_at, :datetime
  end
end
