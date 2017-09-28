class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
    	t.string :status, null: false, default: "pending"
    	t.integer :template_id, null: false
    	t.string :to, null: false
    	t.string :from, null: false
    	t.json :options
    	t.text :error
      t.timestamps
    end

    add_index :emails, :status
  end
end
