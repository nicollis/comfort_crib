class Profile < ActiveRecord::Base
  belongs_to :guest

  mount_uploader :avatar, AvatarUploader
  
  validates_presence_of :name
  validates_presence_of :bio
  validates_presence_of :guest_id
end
