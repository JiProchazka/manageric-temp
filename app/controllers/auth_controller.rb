class AuthController < ApplicationController
  def new
    @login_user = User.new
  end

  def create
    user = User.authenticate create_permit
    unless user.nil?
      LoginUserService.new.set_as_logged user, session
      redirect_to action: "dashboard", controller: "home"
    else
      @login_user = User.new({email: create_permit["email"]})
      flash[:alert] = "Email or password is wrong"
      render "new"
    end
  end

  def destroy
    session[:user] = nil
    redirect_to login_url
  end

  private

  def create_permit
    params.require(:user).permit(:email, :password)
  end
end
