class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_user, only: [:update]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by!(email: params[:email])
    if @user && !@user.passwd_changed && params[:password]
      @user.update(password: params[:password], passwd_changed: true)
      session[:user_id] = @user.id
    end
    redirect_to '/welcome'
  end

  def edit
  end

  def update
    if @user.update(params.require(:user).permit(:api_key))
      redirect_to root_path
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find_by!(id: params[:id])
  end

end
