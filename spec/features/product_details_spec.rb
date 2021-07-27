require 'rails_helper'

RSpec.feature "Visitor navigates from home page to the product detail page by clicking on a product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see product details" do

    # ACT
    visit root_path

    first('.product img').click
    expect(page).to have_css 'article.product-detail', count: 1
    within('header'){
      expect(page).to have_text @category.name
      expect(page).to have_text @category.products[9].name
    }

     # DEBUG / VERIFY
     save_screenshot
  end

end

