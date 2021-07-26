require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "saves successfully when all fields are set" do
      @category = Category.new
      @category.name = "Tools"
      @category.save
      @product = Product.new
      @product.category_id = @category.id;
      @product.name = "Hammer"
      @product.price = 2000
      @product.quantity = 10
      @product.save
      expect(@product.errors).to be_empty
    end

    it "validates: name, presence: true" do
      @category = Category.new
      @category.name = "Tools"
      @category.save
      @product = Product.new
      @product.category_id = @category.id;
      @product.name = nil
      @product.price = 2000
      @product.quantity = 10
      @product.save
      expect(@product.errors).not_to be_empty
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it "validates: price, presence: true" do
      @category = Category.new
      @category.name = "Tools"
      @category.save
      @product = Product.new
      @product.category_id = @category.id;
      @product.name = "Hammer"
      @product.price = nil
      @product.quantity = 10
      @product.save
      expect(@product.errors).not_to be_empty
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it "validates: quantity, presence: true" do
      @category = Category.new
      @category.name = "Tools"
      @category.save
      @product = Product.new
      @product.category_id = @category.id;
      @product.name = "Hammer"
      @product.price = 2000
      @product.quantity = nil
      @product.save
      expect(@product.errors).not_to be_empty
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "validates: category, presence: true" do
      @product = Product.new
      @product.category_id = nil;
      @product.name = "Hammer"
      @product.price = 2000
      @product.quantity = 10
      @product.save
      expect(@product.errors).not_to be_empty
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
