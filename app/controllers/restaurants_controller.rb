class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [ :show, :update, :destroy, :menus ]

  def index
    @restaurants = Restaurant.all
    render json: @restaurants
  end

  def show
    render json: @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render json: @restaurant, status: :created
      return
    end
    render json: @restaurant.errors, status: :unprocessable_entity
  end

  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
      return
    end
    render json: @restaurant.errors, status: :unprocessable_entity
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  def menus
    render json: @restaurant.menus
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find_by(id: params[:id])
    head :not_found unless @restaurant
    nil if @restaurant  # Adicionei este return
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
