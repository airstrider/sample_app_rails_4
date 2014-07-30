module SessionsHelper
	def sign_in(user)
		remember_token = User.new_remember_token
		# cookies have just encoded strings with base64, not digested.
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user		
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user		
	end

	# Finding the current user using the remember_token
	def current_user
		remember_token = User.digest(cookies[:remember_token])
		# ||= (evaluating from left to right and stopping on the first true value)
		@current_user ||= User.find_by(remember_token: remember_token)	
	end

	def current_user?(user)
		user == current_user		
	end

	# Moved from UserController in order to apply to multi purpose
	def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

	def sign_out
		current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil		
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)		
	end

	def store_location
		session[:return_to] = request.url if request.get?		
	end
end
