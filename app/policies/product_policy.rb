class ProductPolicy < ApplicationPolicy

  attr_reader :current_user, :product

  def initialize(current_user, product)
    @current_user = current_user
    @product = product
  end

  def create?
    @current_user.admin?
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    @current_user.admin?
  end
end
