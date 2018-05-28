class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :oid, index: true, unique: true
      t.string :name
      t.string :email
      t.text :notes

      t.timestamps
    end
  end
end
