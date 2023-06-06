class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments, id: :uuid do |t|

      t.string :user_id
      t.string :stripe_id
      t.integer :status, default: 0

      ## Stripe Related
      t.string :stripe_id
      t.timestamps
    end
  end
end
