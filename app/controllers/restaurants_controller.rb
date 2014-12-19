class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(name: params[:restaurant][:name], address: params[:restaurant][:address],
    city: params[:restaurant][:city], state: params[:restaurant][:state], zip_code: params[:restaurant][:zip_code],
    description: params[:restaurant][:description], category: params[:restaurant][:category])

    if @restaurant.save
      flash[:notice] = "Successfully created restaurant"
      redirect_to "/restaurants/#{@restaurant.id}"
    else
      render "new"
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = Review.where(restaurant_id: @restaurant.id)
  end

  def update
  end

end
