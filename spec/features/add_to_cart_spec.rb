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

    within('nav') {
      expect(page).to have_text "My Cart (0)"
    }

    find('form[action="/cart/add_item?product_id=10"]').click

    within('nav') {
      expect(page).to have_text "My Cart (1)"
    }

    find('form[action="/cart/add_item?product_id=9"]').click

    within('nav') {
      expect(page).to have_text "My Cart (2)"
    }


    # DEBUG / VERIFY
    save_screenshot
  end

end
