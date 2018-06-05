class AddCancelledAtAndRemoveActiveFromSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :cancelled_at, :datetime
    remove_column :subscriptions, :active
  end
end
