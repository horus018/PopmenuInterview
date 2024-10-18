class MenuItemsController < ApplicationController
  before_action :set_menu
  before_action :set_menu_item, only: [ :show, :update, :destroy ]

  def index
    render json: @menu.menu_items
  end

  def show
    render json: @menu_item
  end

  def create
    @menu_item = @menu.menu_items.new(menu_item_params)
    if @menu_item.save
      render json: @menu_item, status: :created
      return
    end
    render json: @menu_item.errors, status: :unprocessable_entity
  end

  def update
    if @menu_item.update(menu_item_params)
      render json: @menu_item
      return
    end
    render json: @menu_item.errors, status: :unprocessable_entity
  end

  def destroy
    if @menu_item.destroy
      head :no_content
      return
    end
    head :not_found
  end

  private

  def set_menu
    @menu = Menu.find_by(id: params[:menu_id])
    head :not_found unless @menu
  end

  def set_menu_item
    @menu_item = MenuItem.find_by(id: params[:id])
    head :not_found unless @menu_item
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :price)
  end
end
