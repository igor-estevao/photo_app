class CreateSubscriptionItems < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_items, id: :uuid do |t|

      t.timestamps
    end
  end
end
