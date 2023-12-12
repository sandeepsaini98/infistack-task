class CustomFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create, :new, :show, :index, :edit, :destroy]
  before_action :set_custom_field, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @custom_fields = @user.custom_fields
  end

  def show
  end

  def new
    @custom_field = {}
  end

  def edit
  end

  def update
    rv = @custom_field.update_self(create_params)

    redirect_to @custom_field.user, notice: 'Custom Field was successfully updated.'
  end

  def create
    rv = CustomField.create_new(create_params, @user)
    if (rv[:error])
      render :rv
    end

    redirect_to @user, notice: 'Custom Field was successfully added.'
  end
  
  def destroy
    @custom_field.destroy

    redirect_to @user, notice: 'Custom Field was successfully removed.'
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

  def authorize_user!
    unless current_user.id == @custom_field.user_id
      redirect_to root_path, alert: "You don't have permission to do that."
    end
  end
end
