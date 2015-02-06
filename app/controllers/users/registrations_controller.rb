class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  def create
    puts build_resource(sign_up_params).to_yaml
 
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        return render json: {success: true, email: current_user.email, username: current_user.username, id: current_user.id}
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        return render json: {success: true, email: current_user.email, username: current_user.username, id: current_user.id}
      end
    else
      clean_up_passwords resource
      return render json: {:success => false, :message => resource.errors}, status: 400
    end

  end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up).push(:username)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end
  
  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end
