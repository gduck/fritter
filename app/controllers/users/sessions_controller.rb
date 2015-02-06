class Users::SessionsController < Devise::SessionsController
  # before_filter :configure_sign_in_params, only: [:create]

 #  after_filter :set_csrf_headers, only: [:create, :destroy]

  def create
    # resource = warden.authenticate!(:scope => resource_name, :recall => "users/sessions#failure")
    # puts "resourcename & resource" + resource_name + resource
    # return sign_in_and_redirect(resource_name, resource)

    render json: {success: true, email: current_user.email, username: current_user.username, id: current_user.id}
  end
  
 #  def sign_in_and_redirect(resource_or_scope, resource=nil)
 #    scope = Devise::Mapping.find_scope!(resource_or_scope)
 #    resource ||= resource_or_scope
 #    set_flash_message(:notice, :signed_in) if is_flashing_format?
 #    sign_in(scope, resource) unless warden.user(scope) == resource
 #    return render json: {:success => true, :message => "success"}, status: 201
 #  end
 
 #  def failure
 #    return render json: {:success => false, :message => "failed"}, status: 401
 #  end

 # def destroy
 #    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
 #    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
 #    # yield if block_given?
 #    render json: {:success => true, :message => "logged out"}
 #  end

 #  protected

 #  def set_csrf_headers
 #    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?  
 #  end
end
