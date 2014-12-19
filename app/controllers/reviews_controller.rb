class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.create(rating: params[:review][:rating], body: params[:review][:body], restaurant_id: @restaurant.id)
    if @review.save
      flash[:notice] = "Successfully posted review"
      redirect_to @restaurant
    else
      render 'new'
    end
  end
end
