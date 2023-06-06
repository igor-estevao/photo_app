class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers, id: :string do |t|
      t.string :user_id # used to identify the user
      t.string :stripe_id
      # t.string :email
    end
  end
end
