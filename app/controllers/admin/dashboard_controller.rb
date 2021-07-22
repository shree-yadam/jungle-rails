class Admin::DashboardController < ApplicationController

  before_filter :authorize_user

  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
