class Price < ApplicationRecord
  before_save :set_uuid_id

  has_many :plans
end
