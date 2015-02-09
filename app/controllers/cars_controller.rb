class CarsController < ApplicationController

	def index
		@cars = Car.paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@car = Car.new

	end

	def create
		@car = Car.new(car_params)
	  if @car.save
	    redirect_to :action => :index
	  else
	    render 'new'
	  end
	end

	def edit

	end

	def update

	end

	def destroy

	end

	private

  def car_params
    params.require(:car).permit(:plate_number, :name)
  end
	
end
