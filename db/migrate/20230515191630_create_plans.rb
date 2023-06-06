class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans, id: :uuid do |t|
      t.string :name
      t.string :short_name
      t.string :description
      t.string :price_id
      ## Stripe Related
      t.string :stripe_id
      t.timestamps
    end
  end
end
