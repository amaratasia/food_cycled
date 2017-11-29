class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :authenticate_with_token
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def authenticate_with_token
  	current_user ||= nil
  	if (params[:emaill].present? && params[:passwordd].present?)
  		user = User.find_by_email(params[:emaill])
      return render json: {status: 'fail'} if user.blank?
	  	sign_in user if user.valid_password? params[:password]
  	elsif params[:token]
  		user = User.find_by_token_and_role(params[:token], params[:role])
      return render json: {status: 'fail'} if user.blank?
  		sign_in user
  	end
  end

  protected
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end


end
