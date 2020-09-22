require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
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

  scenario "They add a product to the cart" do
    # ACT
    visit root_path 
   
    # Click on first Add button
    first('.btn-primary').click
    
    sleep(1)

    # DEBUG
    save_screenshot 'test3-add_item_to_cart.png'

    #VERIFY
    expect(page).to_not have_content 'My Cart (0)'
    expect(page).to have_content 'My Cart (1)'
  
  end

end
