require 'rails_helper'

feature "guest profiles" do 
    let(:guest) {FactoryGirl.create(:guest)}

    before do
        login_as(guest, scope: :guest)
    end 

    scenario "guest creates profile" do
        visit new_guest_profile_path(guest)
        expect(page).to have_content("Create a new Profile")
        fill_in "profile[name]", with: Faker::Name.name
        fill_in "profile[bio]", with: Faker::Lorem.paragraph(2)
        click_button "Create Profile"
        expect(page).to have_content("Profile was successfully created.")
    end

    scenario "guest sees profile error message if no name" do
        visit new_guest_profile_path(guest)
        expect(page).to have_content("Create a new Profile")
        fill_in "profile[bio]", with: Faker::Lorem.paragraph(2)
        click_button "Create Profile"
        expect(Profile.count).to eq 0
        expect(page).to have_content("Create a new Profile")
        expect(page).to have_content("Name can't be blank")
    end
    
    scenario "guest sees profile error message if no bio" do
        visit new_guest_profile_path(guest)
        expect(page).to have_content("Create a new Profile")
        fill_in "profile[name]", with: Faker::Name.name
        click_button "Create Profile"
        expect(Profile.count).to eq 0
        expect(page).to have_content("Create a new Profile")
        expect(page).to have_content("Bio can't be blank")
    end
end