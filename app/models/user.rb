class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true
  validates :mobile_number, presence: true

  has_many :custom_fields, dependent: :destroy
  accepts_nested_attributes_for :custom_fields

  class << self
    def create_new(inputs)
      user_inputs = inputs.slice(:name, :email, :password, :mobile_number)
      user = User.new(user_inputs)
      user.save!

      user.create_custom_fields(inputs['custom_fields_attributes']['0'])
      return { success: true, user: user}
    end
  end #__End of class << self

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user |
    user.provider = auth.provider
    user.name = auth.info.name
    user.uid = auth.uid
    user.email = auth.info.email
    user.mobile_number = '8009001000'
    user.password = Devise.friendly_token[0,20]
    end
  end

  def create_custom_fields(inputs)
    CustomField.create_new(inputs, self)
  end
  
  def update_profile(inputs)
    rv = validate_custom_field(inputs['custom_field_id'])
    if (rv[:error])
      return rv
    end

    custom_field = rv[:custom_field]
    custom_field.update_self(inputs['custom_fields_attributes']['0'])

    user_inputs = inputs.slice(:name, :email, :mobile_number)
    self.update!(user_inputs)

    return { success: true, user: self }
  end

  private

  def validate_custom_field(custom_field_id)
    custom_field = CustomField.find_by(id: custom_field_id)
    if (custom_field.nil?)
      return { error: true, message: 'CustomField not found for specifed ID' }
    end

    if (custom_field.user_id != self.id)
      return { error: true, message: 'You are not authorized to access this resource.' }
    end

    return { success: true, custom_field: custom_field }
  end
end
