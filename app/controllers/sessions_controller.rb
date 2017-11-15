class SessionsController < ApplicationController
	skip_before_action :authenticate_user!, :authenticate_with_token
	def signin
		if (params[:email].present? && params[:password].present?)
  			user = User.find_by_email(params[:email])
  			return render json: {}, status: 401 if user.blank?
  			# raise 'amar'
  			if user.valid_password? params[:password]
	  			sign_in user
	  			return render json: {token: user.regenerate_token, user: user}, donot_track: true  
	  		else
	  			return render json: {}, status: 401
	  		end
	  	end
	  	return render json: {}, status: 401
	end

	def signUP
		return render json: {user: User.create!(session_params)}
	end

	def session_params
		params.permit(:email, :password, :phone, :address, :house, :code, :role)
	end
end
