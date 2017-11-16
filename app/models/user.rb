class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


    before_create :assign_token

    def assign_token
    	self.token = Devise.friendly_token.first(18)
    end
	def regenerate_token
		self.token = Devise.friendly_token.first(18)	
		self.save
		return self.token
	end	

  def user?
    self.role == 1 
  end
  def volunteer?
    self.role == 2
  end

end
