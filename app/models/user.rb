class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :events, as: :creator
  has_one_attached :avatar

  after_save :create_anniversary_events
  before_create :set_default_avatar

  def generate_jwt
    JWT.encode(
      {
        id: id,
        exp: 60.days.from_now.to_i,
      },
      Rails.application.secrets.secret_key_base
    )
  end

  def create_anniversary_events
    events.system_generated.destroy_all

    events.system_generated.create(
      start_date: dob, end_date: dob, name: "Happy Birthday #{full_name}",
      color: '#825a2c'
    )
    events.system_generated.create(
      start_date: doj, end_date: doj, name: "Happy Work Anniversary #{full_name}",
      color: '#0077B5'
    )
  end

  def set_default_avatar
    self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar')), filename: 'default-avatar', content_type: 'image/jpeg')
  end
end
