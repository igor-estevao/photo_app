class CustomerPlan < ApplicationRecord
  before_save :set_uuid_id

  belongs_to :plan
  belongs_to :customer

  after_create_commit -> do # Ex: customer_123_plans
    channel_name = "customer_#{self.customer.id}_plans"
    broadcast_append_to(channel_name, target: channel_name, partial: 'plans/signed_plan', locals: { plan: self.plan })

    channel_name = "customer_#{self.customer_id}_avaible_plans"
    broadcast_remove_to(channel_name, target: "plan_#{self.plan.id}")
  end

  after_destroy_commit -> do
    channel_name = "customer_#{self.customer_id}_plans"
    broadcast_remove_to(channel_name, target: "plan_#{self.plan.id}")
    
    channel_name = "customer_#{self.customer_id}_avaible_plans"
    broadcast_append_to(channel_name, target: channel_name, partial: 'plans/plan', locals: { plan: self.plan })
  end

end
