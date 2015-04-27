class AlertsController < ApplicationController
	def index
		@alerts = SparePart.where("amount_in_stock <= ?", 20)
	end
end
