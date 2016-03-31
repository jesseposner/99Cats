class AddUserIdToCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer
    add_index :cats, :user_id, unique: true
    change_column_null :cats, :user_id, false
  end
end
