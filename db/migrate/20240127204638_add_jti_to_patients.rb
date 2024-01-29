class AddJtiToPatients < ActiveRecord::Migration[7.1]
  def change
    add_column :patients, :jti, :string, null: false
    add_index :patients, :jti, unique: true
  end
end
