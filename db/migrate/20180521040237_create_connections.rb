class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :other_user_id
      t.string :status

      t.timestamps
    end
  end
end
