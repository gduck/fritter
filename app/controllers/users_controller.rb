class UsersController < ApplicationController

  def create
    User.create(permitted_params)
  end

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

  def edit
    if user_signed_in?
      # @user=current_user

      current_user.update_attributes(:username => params[:username])
        # , :userprofile => params[:userprofile]

      render json: {signedIn: user_signed_in?, id: get_id, username: current_user.username, email: get_email} 
      # userprofile: current_user.userprofile

    else
      return nil
    end
  end

  def index
    @user = User.all

  end

  protected

  def permitted_params 
    params.require(:user).permit(:id, :email, :username)
  end

end
