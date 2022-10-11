class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all

    render json: @products
  end

  def show
    @product = Product.find(params[:id])

    render json: @product
  end

  def create
    authorize Product
    @product = Product.new(product_params)
    if @product.save
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    if @product.destroyed?
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :bad_request
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :image_url, :price)
  end
end
