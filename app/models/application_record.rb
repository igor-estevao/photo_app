class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def set_uuid_id
    self.id = UUID.generate if self.id.nil?
  end

end
