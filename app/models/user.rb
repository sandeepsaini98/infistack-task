class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "Invalid email format" }
  validates :password, presence: true
  validates :mobile_number, presence: true, format: { with: /\A\d{10}\z/, message: "Invalid mobile number format" } 

  has_many :custom_fields, dependent: :destroy
  accepts_nested_attributes_for :custom_fields

  class << self
    def create_new(inputs)
      user_inputs = inputs.slice(:name, :email, :password, :mobile_number)
      user = User.new(user_inputs)
      user.save!

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
    user_inputs = inputs.permit(:name, :email, :password, :mobile_number)
    self.update!(user_inputs)
 
    { success: true, user: self }
  end
  
end
