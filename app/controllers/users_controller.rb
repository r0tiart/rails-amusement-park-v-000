class UsersController < ApplicationController
	before_action :require_login  
	skip_before_action :require_login, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if !!@user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			render "/users/new"
		end
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def edit
		@user = User.find_by(id: params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		redirect_to user_path(@user)
	end


	private
	def user_params
		params.require(:user).permit(:name, :password, :height, :nausea, :happiness, :admin, :tickets)
	end

	def require_login
		unless logged_in?
			flash[:error] = "You must be logged in to access this section"
			redirect_to "/"
		end
	end
end