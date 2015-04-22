class HistoricalReportsController < ApplicationController
	def index
		@car_histories = CarHistory.all
	end
end
