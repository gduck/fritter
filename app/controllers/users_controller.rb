class UsersController < ApplicationController
  def any
    puts user_signed_in?
    render json: {signedIn: user_signed_in?}
  end  
end
