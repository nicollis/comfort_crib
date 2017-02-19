require 'carrierwave/test/matchers'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) {FactoryGirl.create(:profile)}
  let(:uploader) { AvatarUploader.new(user, :avatar) }

  before do
    AvatarUploader.enable_processing = true
    File.open('spec/fixtures/images/avatar.png') { |f| uploader.store!(f) }
  end

  after do
    AvatarUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it "scales down a landscape image to be exactly 150 by 150 pixels" do
      expect(uploader.thumb).to have_dimensions(150, 150)
    end
  end

  it "makes the image readable only to the owner/group/other and not executable" do
    expect(uploader).to have_permissions(0644)
  end

  it "has the correct format" do
    expect(uploader).to be_format('png')
  end
end