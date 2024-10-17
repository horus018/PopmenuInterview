class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [ :show, :update, :destroy ]
  before_action :set_menu, only: [ :index, :create, :destroy_menu_item ]

  def index
    @menu_items = @menu.menu_items
    render json: @menu_items
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
    head :unprocessable_entity
  end

  def update
    if @menu_item.update(menu_item_params)
      render json: @menu_item
      return
    end
    head :unprocessable_entity
  end

  def destroy
    @menu_item.destroy
    head :no_content
  end

  def destroy_menu_item
    if @menu.menu_items.delete(@menu_item)
      head :ok
      return
    end
    head :unprocessable_entity
  end

  private

  def set_menu_item
    @menu_item = MenuItem.find_by(id: params[:id])
    head :not_found unless @menu_item
  end

  def set_menu
    @menu = Menu.find_by(id: params[:menu_id])
    head :not_found unless @menu
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :price)
  end
end
