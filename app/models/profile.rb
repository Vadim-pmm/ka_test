class Profile < ApplicationRecord
  validates_with CustomProfileValidator
  scope :only_active, -> { where(act: true) }

  belongs_to :user

  mount_uploader :avatar, AvatarUploader
end
