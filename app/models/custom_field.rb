class CustomField < ApplicationRecord
  belongs_to :user

  def update_self(inputs)
    self.update!(inputs)
  end
end
