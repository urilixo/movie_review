class UsersController < ApplicationController
  before_action :set_user, only: %i[require_correct_user show]
  before_action :require_signin, except: %i[new create]
  before_action :require_correct_user, only: %i[edit update destroy]

  def index
    @users = User.normal_users
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile succesfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil unless current_user_admin? && @user.admin? == false
    redirect_to users_url, status: :see_other, alert: 'Profile deleted.'
  end

  private

  def set_user
    @user = User.find_by!(slug: params[:id])
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to :root, alert: 'Access Denied.' unless current_user?(@user) || current_user_admin?
  end

  def user_params
    params.require(:user)
          .permit(:username, :name, :email, :password, :password_confirmation)
  end
end
