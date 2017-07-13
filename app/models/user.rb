class User < ActiveRecord::Base
  # write associations here
  has_many :rides
  has_many :attractions, through: :rides
  has_secure_password

  def mood
  	if happiness > nausea
  		@mood = "happy"
  	else
  		@mood = "sad"
  	end
  end
end
