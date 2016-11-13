require 'rails_helper'

feature "signing in" do
  let(:guest) {FactoryGirl.create(:guest)}
  
  def fill_in_signin_fields
    fill_in "guest[email]", with: guest.email
    fill_in "guest[password]", with: guest.password
    click_button "Log in"
  end
  
  scenario "visiting the site to sign in" do
    visit root_path
    click_link "Log in"
    fill_in_signin_fields
    expect(page).to have_content("Signed in successfully.")
  end
end