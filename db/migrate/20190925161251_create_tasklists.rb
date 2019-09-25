class CreateTasklists < ActiveRecord::Migration[5.2]
  def change
    create_table :tasklists do |t|
      t.string :content

      t.timestamps
    end
  end
end
