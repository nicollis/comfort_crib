require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe "associations" do 
    it { should have_one(:profile) }
  end
end
