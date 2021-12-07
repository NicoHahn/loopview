class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_user, only: [:update]

  def index
  end

  def new
    @new_user = User.new
  end

  def create
    if logged_in?
      @new_user = User.create(email: params[:email], password: User.generate_password)
      if @new_user
        redirect_to '/'
        flash[:success] = "Nutzerdaten erfolgreich hinterlegt!"
      else
        redirect_to '/'
        flash[:danger] = "Es scheint, als würde bereits ein Nutzer mit dieser E-Mail-Adresse existieren!"
      end
    else
      @new_user = User.find_by!(email: params[:email])
      if @new_user && !@new_user.passwd_changed && params[:password] && JiraConnector.verify_user(params[:email], params[:api_key])
        @new_user.update(password: params[:password], passwd_changed: true, api_key: params[:api_key], firstname: params[:firstname], lastname: params[:lastname])
        session[:user_id] = @new_user.id
      end
      redirect_to '/'
      flash[:success] = "Nutzerdaten aktualisiert!"
    end
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
