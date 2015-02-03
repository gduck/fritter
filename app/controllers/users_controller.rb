class UsersController < ApplicationController

  def get
    @user = current_user
    # puts "in CONTROLLER current_user " + current_user.email
    render json: {signedIn: user_signed_in?, id: get_id, username: get_username, email: get_email}
  end

  def get_username
    if user_signed_in?
      return current_user.username
    else   
      return nil
    end
  end

  def get_email
    if user_signed_in?
      return current_user.email
    else
      return nil
    end
  end

  def get_id
   if user_signed_in?
      return current_user.id
   else   
      return nil
   end
  end 

  protected
  
  def permitted_params 
    params.require(:user).permit(:email, :username)
  end

end
