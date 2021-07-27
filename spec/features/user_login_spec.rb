require 'rails_helper'

RSpec.feature "Visitor can login successfully and is taken to home page once they are signed in", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create! first_name: 'ABC', last_name: 'XYZ', email: 'test@test.com', password: 'password', password_confirmation: 'password'
  end

  scenario "They see product details page and see logged in message in nav bar" do

    # ACT
    visit root_path

    click_link 'Login'
    expect(page).to have_selector 'form'
    expect(page).to have_button 'Login'

    fill_in 'session_email', with: 'test@test.com'
    fill_in 'session_password', with: 'password'

    click_button 'Login'

    expect(page).to have_text 'Products'
    within('nav') {
      expect(page).to have_text "Hello ABC XYZ"
      expect(page).to have_link 'Logout'
    }

    # DEBUG / VERIFY
    save_screenshot

  end


end
