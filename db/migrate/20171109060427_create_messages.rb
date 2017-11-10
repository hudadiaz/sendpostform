class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :mailbox
      t.string :content

      t.timestamps
    end
  end
end
