class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    redirect_to('/') if logged_in?
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) && @user.passwd_changed
      session[:user_id] = @user.id
      if @user.api_key.blank?
        redirect_to '/'
      else
        redirect_to '/'
      end
      flash[:success] = "Erfolgreich angemeldet!"
    else
      redirect_to '/login', danger: "Ungültige E-Mail / Passwort Kombination"
    end
  end

  def destroy
    session.destroy
    redirect_to '/login'
    flash[:success] ="Erfolgreich abgemeldet!"
  end

  def login

  end

end
