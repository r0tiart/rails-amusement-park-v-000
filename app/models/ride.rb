class Ride < ActiveRecord::Base
  # write associations here
  belongs_to :attraction
  belongs_to :user

  def take_ride
  	if user.height < attraction.min_height || user.tickets < attraction.tickets
      unable_to_ride
  	else
  		user.tickets -= attraction.tickets
  		user.happiness += attraction.happiness_rating
  		user.nausea += attraction.nausea_rating
  		user.save
  	end
  end

  def unable_to_ride
      if user.height < attraction.min_height && user.tickets < attraction.tickets
        "Sorry. You do not have enough tickets to ride the Roller Coaster. You are not tall enough to ride the Roller Coaster."
      elsif user.height < attraction.min_height
        "Sorry. You are not tall enough to ride the #{attraction.name}."
      else
        "Sorry. You do not have enough tickets to ride the #{attraction.name}."
      end
  end
end
