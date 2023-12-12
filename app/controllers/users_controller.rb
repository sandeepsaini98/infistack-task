class UsersController < ApplicationController
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
    @user.custom_fields.build
  end

  def create
    rv = User.create_new(user_params)
    if (rv[:error])
      render :rv
    end

    @user = rv[:user]
    sign_in(@user)
    redirect_to @user, notice: 'User was successfully created.'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    rv = @user.update_profile(user_params)
    if (rv[:error])
      render :edit
    end

    @user = rv[:user]
    redirect_to @user, notice: 'User was successfully updated.'
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :mobile_number)
  end

  def authorize_user!
    unless current_user == User.find(params[:id])
      redirect_to root_path, alert: "You don't have permission to do that."
    end
  end
end
