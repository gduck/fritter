class UsersController < ApplicationController

  def get
    render json: {signedIn: user_signed_in?, username: get_username, email: get_email}
  end

  def get_username
    if user_signed_in?
      return current_user.username
    end
  end

  def get_email
    if user_signed_in?
      return current_user.email
    end
  end

end
