class User < ApplicationRecord
  include ActiveModel::Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_with CustomUserValidator
  after_validation :split_name

  scope :all_active, -> { where(id: Profile.where(act: true).pluck(:user_id)) }

  has_one  :profile
  has_many :comments

  def has_profile?
    profile.nil? ? false : true
  end

  private

  def split_name
    names = self.name.split(' ')

    self.surname     = names[0]
    self.name        = names[1]
    self.father_name = names[2]
  end

end
