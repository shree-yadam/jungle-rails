class Admin::CategoriesController < Admin::AuthController

  def index
    @categories = Category.all
    puts @categories.inspect
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories],
      notice: 'Category created!'
    else
      render :new
    end
  end

  def destroy
    @category = Category.find params[:id]
    if @category.destroy
      redirect_to [:admin, :categories],
      notice: 'Category deleted!'
    else
      redirect_to [:admin, :categories], notice: 'Category not empty! Remove products before deleting category.'
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
