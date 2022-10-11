class ProductsController < ApplicationController
  def index
    @products = Product.all

    render json: @products
  end

  def show
    @product = Product.find(params[:id])

    render json: @product
  end

  def create
    @product = Product.new(product_params)
    render json: 'sorry, you can not create idea for someone else', status: :unprocessable_entity if current_user.is_admin?

    if @product.save
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
end
