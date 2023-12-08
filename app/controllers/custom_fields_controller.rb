class CustomFieldsController < ApplicationController
  before_action :set_user

  def index
    @custom_fields = @user.custom_fields
  end

  def new
    @custom_field = {}
  end

  def create
    @user.custom_fields.merge!(custom_field_params)
    if @user.save
      redirect_to user_custom_fields_path(@user), notice: 'Custom field was successfully created.'
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def custom_field_params
    params.require(:custom_field).permit(:field_name, :input_type, :default_value)
  end
end
