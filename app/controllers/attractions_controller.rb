class AttractionsController < ApplicationController
	before_action :require_login  

	def index
		@attractions = Attraction.all
	end

	def show
		@attraction = Attraction.find_by(id: params[:id])
	end

	def ride
		
		attraction = Attraction.find_by(id: params[:id])
		ride = Ride.new(user_id: current_user.id, attraction_id: params[:id])
		ride.save

		if ride.take_ride.class != String
			session[:thanks] = true
			session[:message] = "Thanks for riding the #{attraction.name}!"
			redirect_to user_path(current_user)
		else
			session[:message] = ride.take_ride
			session[:error] = true
			redirect_to user_path(current_user)
		end
	end

	def new
		if current_user.admin
			@attraction = Attraction.new
		else
			redirect_to user_path(current_user)
		end
	end

	def create
		@attraction = Attraction.new(attraction_params)
		if !!@attraction.save
			redirect_to attraction_path(@attraction)
		else
			render new_attraction_path
		end
	end

	def edit 
		@attraction = Attraction.find_by(id: params[:id])
	end

	def update
		@attraction = Attraction.find_by(id: params[:id])
		@attraction.update(attraction_params)
		redirect_to attraction_path(@attraction)	
	end


	private
	def attraction_params
		params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
	end

	def require_login
		unless logged_in?
			flash[:error] = "You must be logged in to access this section"
			redirect_to "/"
		end
	end
end