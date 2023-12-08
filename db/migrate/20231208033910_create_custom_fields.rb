class CreateCustomFields < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_fields do |t|
      t.references :user, null: false, foreign_key: true
      t.string :field_name
      t.string :input_type
      t.string :default_value

      t.timestamps
    end
  end
end
