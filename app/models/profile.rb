class Profile < ActiveRecord::Base
  belongs_to :guest

  mount_uploader :avatar, AvatarUploader
  
  validates_presence_of :name
  validates_presence_of :bio
  validates_presence_of :guest_id

  def avatar_url
    self.avatar.try(:url) || 'default-profile-picture.png'
  end
end
