class Profile < ActiveRecord::Base
  belongs_to :guest
  # validates :name, presence: true
end
