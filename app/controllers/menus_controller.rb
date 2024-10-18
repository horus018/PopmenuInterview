class MenusController < ApplicationController
  before_action :set_menu, only: [ :show, :update, :destroy, :menu_items ]

  def index
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    head :not_found unless @restaurant
    render json: @restaurant.menus
  end

  def show
    render json: @menu
  end

  def create
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    head :not_found unless @restaurant
    @menu = @restaurant.menus.new(menu_params)
    if @menu.save
      render json: @menu, status: :created
      return
    end
    render json: @menu.errors, status: :unprocessable_entity
  end

  def update
    if @menu.update(menu_params)
      render json: @menu
      return
    end
    render json: @menu.errors, status: :unprocessable_entity
  end

  def destroy
    @menu.destroy
    head :no_content
  end

  def menu_items
    render json: @menu.menu_items
  end

  private

  def set_menu
    @menu = Menu.find_by(id: params[:id])
    head :not_found unless @menu
  end

  def menu_params
    params.require(:menu).permit(:name, :description, :restaurant_id)
  end
end
