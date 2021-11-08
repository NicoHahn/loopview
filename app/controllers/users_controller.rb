class UsersController < ApplicationController
  #skip_before_action :authorized, only: [:new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:password, :firstname, :lastname, :email))
    # comment this part for now, since atm i think a registration doesnt make sense
    # an admin User or something like that should be able to create a user
    # session[:user_id] = @user.id
    # redirect_to '/welcome'
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
