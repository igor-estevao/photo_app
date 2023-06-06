class Product < ApplicationRecord
  before_save :set_uuid_id

  
  
end
