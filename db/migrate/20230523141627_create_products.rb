class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.string :description


      ## Stripe Related
      t.string :stripe_id
      
      t.timestamps
    end
  end
end
