class AddStatusToTasklists < ActiveRecord::Migration[5.2]
  def change
    add_column :tasklists, :status, :string
  end
end
