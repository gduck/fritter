class UsersController < ApplicationController

  def any
    render json: {signedIn: user_signed_in?}
  end  
end
