module UsersHelper
	def thanks?
		!!session[:thanks]
	end

	def error?
		!!session[:error]
	end

	def message
	   session[:error] = false
	   session[:thanks] = false
	   session[:message]

 	end
end
