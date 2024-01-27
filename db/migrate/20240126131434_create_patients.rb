class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :username
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    add_index :patients, :username, unique: true
  end
end
