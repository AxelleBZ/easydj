class ItemsController < ApplicationController
  before_action :set_items, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:query].present?
     @items = Item.search_by_name_and_description params[:query]
    else
      @items = Item.all
    end
  end

  def create
    @item = Item.new(params_item)

    @item.user = current_user
    if @item.save
      redirect_to dashboard_path(@item)
    else
      render :new
    end
      # need to log in for it to work
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @rental = Rental.new
    @markers = [{lat: @item.latitude,
    lng: @item.longitude}]
  end

  def destroy
    @item.destroy
    redirect_to dashboard_path
  end

  private

  def set_items
    @item = Item.find(params[:id])
  end

  def params_item
    params.require(:item).permit(
      :location, :name, :description, :price, :condition, :deposit,
      :image_url, :delivery, :policies, :photo, :start_date, :end_date
    )
  end
end
