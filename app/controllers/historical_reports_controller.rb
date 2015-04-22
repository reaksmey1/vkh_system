class HistoricalReportsController < ApplicationController
	def index
		@car_histories = CarHistory.all
	end

	def show
		@sell_reports = SellReport.find_by_car_history_id(params[:])
	end
end
