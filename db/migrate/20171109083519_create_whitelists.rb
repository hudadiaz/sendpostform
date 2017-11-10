class CreateWhitelists < ActiveRecord::Migration[5.0]
  def change
    create_table :whitelists do |t|
      t.references :mailbox, foreign_key: true
      t.string :hostname

      t.timestamps
    end
  end
end
