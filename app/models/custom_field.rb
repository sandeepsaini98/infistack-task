class CustomField < ApplicationRecord
  belongs_to :user
  INPUT_TYPES = %w(number text date)

  validates_inclusion_of :input_type, in: INPUT_TYPES
  validates :field_name, uniqueness: { scope: :user_id }

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
