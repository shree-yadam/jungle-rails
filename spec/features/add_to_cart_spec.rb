require 'rails_helper'

RSpec.feature "Visitor can add items to cart from home page", type: :feature, js: true do

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

  scenario "They see the number of items added to cart" do

    # ACT
    visit root_path

    #Check My Cart (0) is displayed on home page before adding item to cart
    within('nav') {
      expect(page).to have_text "My Cart (0)"
    }

    # Add an item to cart
    find('form[action="/cart/add_item?product_id=10"]').click

    # Check Cart in navbar changes to My Cart (1)
    within('nav') {
      expect(page).to have_text "My Cart (1)"
    }

    # Add another item to cart
    find('form[action="/cart/add_item?product_id=9"]').click

    # Check Cart in navbar changes to My Cart (2)
    within('nav') {
      expect(page).to have_text "My Cart (2)"
    }


    # DEBUG / VERIFY
    save_screenshot
  end

end
