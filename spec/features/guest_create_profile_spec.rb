require 'rails_helper'

feature "guest profiles" do 
    let(:guest) {FactoryGirl.create(:guest)}

    before do
        login_as(guest, scope: :guest)
    end 

    scenario "guest creates profile" do
        pic_path = 'spec/fixtures/images/avatar.png'

        visit new_guest_profile_path(guest)
        expect(page).to have_content("Create a new Profile")
        
        attach_file "profile[avatar]", pic_path
        fill_in "profile[name]", with: Faker::Name.name
        fill_in "profile[bio]", with: Faker::Lorem.paragraph(2)
        fill_in "profile[phone]", with: Faker::PhoneNumber.phone_number
        fill_in "profile[address]", with: Faker::Address.street_address
        fill_in "profile[zipcode]", with: Faker::Address.zip_code
        click_button "Create Profile"

        expect(page).to have_content("Profile was successfully created.")

        profile = Profile.last
        expect(profile.avatar_identifier).to eq 'avatar.png'
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