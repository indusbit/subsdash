class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :oid, index: true, unique: true
      t.string :interval, index: true, length: 15
      t.integer :interval_count
      t.decimal :amount, precision: 18, scale: 4
      t.string :currency
      t.string :platform

      t.timestamps
    end
  end
end
