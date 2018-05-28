class CreateSubscriptionPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_plans do |t|
      t.string :name
      t.string :remote_provider_id
      t.decimal :amount, precision: 18, scale: 4
      t.string :currency
      t.string :cycle

      t.timestamps
    end
  end
end
