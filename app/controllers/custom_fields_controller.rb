class CustomFieldsController < ApplicationController
  before_action :set_user, only: [:create, :new, :show, :index]
  before_action :set_custom_field, only: [:edit, :update]

  def index
    @custom_fields = @user.custom_fields
  end

  def show
  end

  def new
    @custom_field = {}
  end

  def edit
    @custom_field = CustomField.find(params[:id])
  end

  def update
    rv = @custom_field.update_self(create_params)
  end

  def create
    rv = CustomField.create_new(create_params, @user)
    if (rv[:error])
      render :rv
    end

    redirect_to @user, notice: 'Custom Field was successfully added.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_custom_field
    @custom_field = CustomField.find(params[:id])
  end

  def create_params
    params.require(:custom_field).permit(:field_name, :input_type, :default_value)
  end

  def update_params
    params.require(:custom_field).permit(:field_name, :input_type, :default_value)
  end
end
