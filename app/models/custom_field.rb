class CustomField < ApplicationRecord
  belongs_to :user
  INPUT_TYPES = %w(number_field text_field date_field)

  class << self
    def create_new(inputs, user)
      custom_field = CustomField.new(inputs)
      custom_field.user = user
      custom_field.save!

      return { success: true }
    end
  end

  def update_self(inputs)
    self.update!(inputs)
  end
end
