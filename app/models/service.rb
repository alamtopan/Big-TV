class Service < ActiveRecord::Base
  attr_accessible :address, :day_problem, :email, :name, :no_customer, :phone, :problem, :program, :status
end
