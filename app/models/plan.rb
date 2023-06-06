class Plan  < ApplicationRecord
  before_save :set_uuid_id
  
  has_many :customer_plans
  has_many :customers, through: :customer_plans
  belongs_to :price
  
  after_create_commit -> do # Ex: customer_123_plans
    channel_name = "avaible_plans"
    broadcast_append_to(channel_name, target: channel_name, partial: 'plans/plan', locals: { plan: self })
  end

  scope :by_customer, ->(customer) {
    joins(:customer_plans)
      .where(customer_plans: { customer_id: customer.id })
  }

  scope :not_in_customer, ->(customer) {
    # customer.present? ? joins(:customers).where.not(customers: { id: customer.id}) : all
    customer.present? ? where.not(id: customer.plans.select(:id)) : all
  }

end
