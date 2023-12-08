class RemoveCustomFieldsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :custom_fields
  end
end
