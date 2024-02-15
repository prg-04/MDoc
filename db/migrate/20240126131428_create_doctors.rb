class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :specialization
      t.string :image
      t.text :bio
      t.decimal :fee

      t.timestamps
    end
  end
end
