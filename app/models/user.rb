class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :events, as: :reference
  has_one_attached :profile_photo, service: :cloudinary_profiles

  before_save do
    @email = email.strip
  end

  after_save :create_anniversary_events

  def slug
    "#{full_name.split(' ').first} #{id}".parameterize
  end

  def generate_jwt
    JWT.encode(
      {
        id: id,
        exp: 60.days.from_now.to_i,
      },
      Rails.application.secret_key_base
    )
  end

  def create_anniversary_events
    events.system_generated.destroy_all

    events.system_generated.create!(
      start_at: dob.beginning_of_day.to_s,
      name: "Happy Birthday #{full_name}",
      color: '#825a2c'
    ).create_system_occurence
    events.system_generated.create!(
      start_at: doj.beginning_of_day.to_s,
      name: "Happy Work Anniversary #{full_name}",
      color: '#0077B5'
    ).create_system_occurence
  end
end
