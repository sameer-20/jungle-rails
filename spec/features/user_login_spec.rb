require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  
  # SETUP
  before :each do
    @user = User.create!(first_name: "Sameer", last_name: "Menda", email: "sam@gmail.com",
      password: "test123", password_confirmation: "test123")
  end

  scenario "They should login on submitting valid credentials" do
    
    visit login_path 
    save_screenshot 'test4.1-login_page.png'

    fill_in 'email', with: 'sam@gmail.com'
    fill_in 'password', with: 'test123'
    sleep(1)
    save_screenshot 'test4.2-enter_login_details.png'
    click_button "Submit"
   
    sleep(1)

    save_screenshot 'test4.3-post_login_page.png'

    #VERIFY
    expect(page).to_not have_content 'Login'
    expect(page).to have_content 'Signed in as Sameer Menda'
    expect(page).to have_content 'Logout'
  
  end

end
