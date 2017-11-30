class SessionsController < ApplicationController
	skip_before_action :authenticate_user!, :authenticate_with_token
	def signin
		if (params[:email].present? && params[:password].present? && params[:role].present?)
  			user = User.find_by_email_and_role(params[:email], params[:role])
  			return render json: {status: 'fail'} if user.blank?
  			# raise 'amar'
  			if user.valid_password? params[:password]
	  			sign_in user
	  			return render json: {status: 'success', token: user.regenerate_token, user: user}, donot_track: true  
	  		else
	  			return render json: {status: 'fail'}
	  		end
	  	end
	  	return render json: {status: 'fail'}
	end

	def signUP
		return render json: {user: User.create!(session_params)}
	end

	def session_params
		params.permit(:email, :password, :phone, :address, :code, :role, :name)
	end
end
