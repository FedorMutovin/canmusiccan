class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time
    created_at.strftime('%d/%m/%y at %l:%M %p')
  end
end
