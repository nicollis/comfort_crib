require 'rails_helper'

feature "signing up" do
  let(:guest) {FactoryGirl.build(:guest)}

  def fill_in_signup_fields
    fill_in "guest[email]", with: guest.email
    fill_in "guest[password]", with: guest.password
    fill_in "guest[password_confirmation]", with: guest.password
    click_button "Sign up"
  end
  
  scenario "visiting the site to sign up" do
    visit root_path
    click_link "Sign up"
    fill_in_signup_fields
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end