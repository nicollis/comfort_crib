require 'rails_helper'

feature "edit guest profiles" do
  let(:profile) { FactoryGirl.create(:profile) }
  let(:guest) { profile.guest }
  let(:new_profile) { FactoryGirl.build(:profile) }

  before do
    login_as(guest, scope: :guest)
  end

  scenario "guest updates profile" do
    pic_path = 'spec/fixtures/images/avatar.png'

    visit edit_guest_profile_path(guest)
    expect(page).to have_content("Edit Profile")

    attach_file "profile[avatar]", pic_path
    fill_in "profile[name]", with: new_profile.name
    fill_in "profile[bio]", with: new_profile.bio
    fill_in "profile[phone]", with: new_profile.phone
    fill_in "profile[address]", with: new_profile.address
    fill_in "profile[zipcode]", with: new_profile.zipcode
    click_button "Submit"

    expect(page).to have_content("Profile updated!")
    profile.reload
    expect(profile.name).to eq new_profile.name
    expect(profile.bio).to eq new_profile.bio
    expect(profile.phone).to eq new_profile.phone
    expect(profile.address).to eq new_profile.address
    expect(profile.zipcode).to eq new_profile.zipcode
  end

end