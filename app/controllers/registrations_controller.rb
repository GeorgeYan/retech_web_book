class RegistrationsController < Devise::RegistrationsController
=begin
  def create
    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
      flash.delete :recaptcha_error
      render :new
    end
  end
=end
  protected
  def after_update_path_for(resource)
    dashboard_path
  end
end
