class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:order_products)
    if current_user.admin?
      @orders = @orders.all
    else
      @orders = Order.includes(:order_products).where(user: current_user)
    end

    render json: @orders.as_json(include: :products)
  end

  def update
    @order = Order.find(params[:id])

    if @order.status == "closed"
      render json: {info: 'order is closed' }
    else
      if current_user.admin? || @order.user == current_user
        @order.products << products_to_add unless products_to_add.nil?
        @order.products.delete(products_to_remove) unless products_to_remove.nil?
        @order.update(status: "closed") unless params[:close].nil? && params[:close] != true

        @order.save

        render json: @order.as_json(include: :products)
      end
    end
  end

  private

  def products_to_remove
    products_ids = JSON.parse(params[:products_to_remove])

    @products_to_remove ||= products_ids.map { |id| Product.find(id) }
  end

  def products_to_add
    products_ids = JSON.parse(params[:products_to_add])

    @products_to_add ||= products_ids.map { |id| Product.find(id) }
  end
end
