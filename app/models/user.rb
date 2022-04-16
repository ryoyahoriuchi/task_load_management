class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :image, ImageUploader

  has_many :tasks, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@mail.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guest'
      user.skip_confirmation!
    end
  end
end
