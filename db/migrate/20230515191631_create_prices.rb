class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices, id: :uuid do |t|

      t.string :description
      t.integer :amount

      ## Stripe Related
      t.string :stripe_id
      t.timestamps
    end
  end
end
