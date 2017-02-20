require 'rails_helper'

describe ProfilePolicy do
  subject { described_class }

  context "for a visitor" do
    let(:guest) { nil }
    let(:profile) { FactoryGirl.create(:profile) }

    permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
      it "does not grant access for non logged in visitors" do
        expect(subject).not_to permit(guest, profile)
      end
    end

  end # visitor context

  context "for guest viewing other guests' profiles or creating a profile" do
    let(:profile) { FactoryGirl.create(:profile) }
    let(:guest) { FactoryGirl.create(:guest) }

    permissions :index?, :show?, :new?, :create? do
      it "grants access to guest" do
        expect(subject).to permit(guest, profile)
      end
    end

    permissions :edit?, :update?, :destroy? do
      it "denies access to guest for whom the profile does not belong" do
        expect(subject).not_to permit(guest, profile)
      end
    end

  end # guest viewing other guest context

  context "for guest editing their own profile" do
    let(:guest) { FactoryGirl.create(:guest) }

    permissions :edit?, :update?, :destroy? do
      it "grants access if profile belongs to guest" do
        expect(subject).to permit(guest, Profile.create!(
          guest_id: guest.id,
          name: Faker::Name.name,
          bio: Faker::Lorem.paragraph(2))
        )
      end
    end

  end # guest editing own profile context

end # ProfilePolicy