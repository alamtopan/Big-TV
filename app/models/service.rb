class Service < ActiveRecord::Base
	# Attributess model Service
  attr_accessible :address, :day_problem, :email, :name, :no_customer, :phone, :problem, :program, :status, :city
end
