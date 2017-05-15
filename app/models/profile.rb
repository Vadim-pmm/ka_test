class Profile < ApplicationRecord
  validates_with CustomProfileValidator
  scope :only_active, -> { where(act: true) }

  belongs_to :user
end
