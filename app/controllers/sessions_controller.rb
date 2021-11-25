class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    redirect_to(welcome_path) if logged_in?
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.api_key.blank?
        redirect_to '/welcome'
      else
        redirect_to projects_path
      end
    else
      redirect_to '/login'
    end
  end

  def destroy
    session.destroy
    redirect_to '/'
  end

  def login

  end

  def welcome
    redirect_to projects_path if current_user.api_key.blank?
  end

end
