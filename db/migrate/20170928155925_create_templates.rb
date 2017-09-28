class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
    	t.string :name, null: false
    	t.string :sendgrid_id, null: false
      t.timestamps
    end

    add_index :templates, :name
  end
end
