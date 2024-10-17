class MenusController < ApplicationController
  before_action :set_menu, only: [ :show, :update, :destroy, :menu_items, :destroy_menu_item ]
  before_action :set_menu_item, only: [ :destroy_menu_item ]

  def index
    @menus = Menu.all
    render json: @menus
  end

  def show
    render json: @menu
  end

  def create
    @menu = Menu.new(menu_params)
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

  def destroy_menu_item
    if @menu.menu_items.include?(@menu_item) && @menu.menu_items.delete(@menu_item)
      head :ok
      return
    end
    head :unprocessable_entity
  end

  private

  def set_menu
    @menu = Menu.find_by(id: params[:id])
    head :not_found unless @menu
  end

  def set_menu_item
    @menu_item = MenuItem.find_by(id: params[:menu_item_id])
    head :not_found unless @menu_item
  end

  def menu_params
    params.require(:menu).permit(:name, :description, :restaurant_id)
  end
end
