class UsersController < ApplicationController

  def create
    User.create(permitted_params)
  end

  def get
    @user = current_user
    @signed_in = user_signed_in?
    # puts "in CONTROLLER current_user " + current_user.email
    # render json: {signedIn: user_signed_in?, id: get_id, username: get_username, email: get_email, userprofile: current_user.userprofile}
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

  def edit
    if user_signed_in?
      puts ">>>>>>>> #{update_params}"
      current_user.update_attributes(update_params)

      render json: {signedIn: user_signed_in?, id: get_id, username: current_user.username, email: get_email, userprofile: current_user.userprofile}

    else
      return nil
    end
  end

  def index
    @user = User.all

  end

  protected

  def permitted_params 
    params.require(:user).permit(:id, :email, :username, :userprofile)
  end

  def update_params 
    params.permit(:username, :userprofile)
  end

end
