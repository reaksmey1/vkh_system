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
				car_id = el[:car_id]
				entry_date = el[:entry_date]
				car_history = CarHistory.find_by_car_id_and_entry_date(car_id, entry_date)
				SellReport.create!(:car_id => params[:id],
													 :spare_part_id => SparePart.find_by_code(el[:code].delete(" ")).id,
													 :unit => el[:amount],
													 :selling_price => el[:unit_price],
													 :total_price => el[:total_price],
													 :recieved => el[:recieved],
													 :sub_total => el[:sub_total],
													 :return => el[:return_money],
													 :status => "Paid",
													 :car_history_id => car_history.id
													)
				spare_part = SparePart.find_by_code(el[:code].delete(" "))
				spare_part.amount_in_stock = spare_part.amount_in_stock.to_f - el[:amount].to_f
				spare_part.save!
			end
			# invoice = Payday::Invoice.new(:invoice_number => 12)
			# invoice.line_items << Payday::LineItem.new(:price => 20, :quantity => 5, :description => "Pants")
			# invoice.line_items << Payday::LineItem.new(:price => 10, :quantity => 3, :description => "Shirts")
			# invoice.line_items << Payday::LineItem.new(:price => 5, :quantity => 200, :description => "Hats")
			# invoice.render_pdf_to_file("to_file.pdf")
			# respond_to do |format|
			#   format.html
			#   format.pdf do
			#     send_data invoice.render_pdf, :filename => "Invoice #12.pdf", :type => "application/pdf", :disposition => "inline"
		 #  	end
			# end
		end
	end
end
