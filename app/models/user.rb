class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
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

  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@mail.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guest_admin'
      user.admin = true
      user.skip_confirmation!
    end
  end
end
