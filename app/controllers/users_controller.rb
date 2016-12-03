class UsersController < ApplicationController
  before_action :verify_permission_and_set, only: [:index, :edit, :update]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if params[:email].blank?

    end

    respond_to do |format|
      if user_params[:password].blank? ? @user.update_without_password(user_params) : @user.update(user_params)
        format.html { redirect_to users_path, notice: 'O usuário foi atualizado com sucesso.' }
        format.json { render :index, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def verify_permission_and_set
    if 'Administrador' == PROFILE_TYPE[current_user.profile_type].first
      set_user(User.find(params[:id])) unless action_name == 'index'
    else
      redirect_to tasks_url
    end
  end

  def set_user(user)
    @user = user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_type)
  end
end