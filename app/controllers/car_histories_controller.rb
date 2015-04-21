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
			@total = @amount.to_i * @spare_part.selling_price
		end
		# @plate_number = "" if @car.nil?
		respond_to do |format|
			format.js
		end
	end

	def print
		if params[:_json].count > 0
			params[:_json].each do |el| 
				SellReport.create!(:car_id => params[:id],
													 :spare_part_id => SparePart.find_by_code(el[:code].delete(" ")).id,
													 :unit => el[:amount],
													 :selling_price => el[:unit_price],
													 :total_price => el[:total_price],
													 :recieved => el[:recieved],
													 :sub_total => el[:sub_total],
													 :return => el[:return_money],
													 :status => "Paid",
													)
			end
		end
		true
	end
end
