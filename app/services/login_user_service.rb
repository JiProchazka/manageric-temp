class LoginUserService
  def set_as_logged user, session
    user.create_token
    session[:user] = user._id.to_s
  end
end
