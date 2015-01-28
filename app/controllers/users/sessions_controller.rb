class Users::SessionsController < Devise::SessionsController
  # sign_in_and_redirect(resource_name, resource)
  # before_filter :configure_sign_in_params, only: [:create]
  after_filter :set_csrf_headers, only: [:create, :destroy]

  respond_to :json

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "users/sessions#failure")
    return sign_in_and_redirect(resource_name, resource)
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render :json => {:success => true}
  end
 
  def failure
    return render :json => {:success => false, :errors => ["Login failed."]}
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    # yield if block_given?
    render json: {:success => true, :message => "logged out"}
  end

  protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  def set_csrf_headers
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?  
  end
end
