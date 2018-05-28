class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :oid, index: true, unique: true
      t.belongs_to :customer, foreign_key: true
      t.belongs_to :plan, foreign_key: true
      t.datetime :started_at
      t.integer :quantity
      t.boolean :active

      t.timestamps
    end
  end
end
