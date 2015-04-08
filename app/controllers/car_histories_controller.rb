class CarHistoriesController < ApplicationController
	def index
		@car = CarHistory.new
		@spare_part = SparePart.new
	end

	def create
		if params[:spare_part]
			spare_part_params = params[:spare_part][:code].split(",")
			@amount = spare_part_params[1]
			code = spare_part_params[0]
			@spare_part = SparePart.find_by_code(code)
			@total = @amount.to_i * @spare_part.based_price
		end
		# @plate_number = "" if @car.nil?
		respond_to do |format|
			format.js
		end
	end
end
