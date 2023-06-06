class CreateCustomerPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_plans, id: :uuid do |t|
      t.string :customer_id
      t.string :plan_id
      # t.integer :status, default: 0
      t.timestamps
    end
  end
end
