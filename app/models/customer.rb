class Customer < ApplicationRecord
  before_save :set_uuid_id

  belongs_to :user
  has_one :payment
  
  has_many :customer_plans
  has_many :plans, through: :customer_plans

  accepts_nested_attributes_for :payment

  def email
    self.user.email
  end

end
