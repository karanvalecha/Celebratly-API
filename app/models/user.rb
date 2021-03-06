class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :events, as: :reference
  has_many :occurrences, through: :events
  has_one_attached :profile_photo, service: :cloudinary_profiles

  scope :all_except, ->(user) { where.not(id: user) }

  before_save do
    @email = email.strip.downcase
  end

  after_create :create_anniversary_events

  def slug
    "#{full_name.split(' ').first} #{id}".parameterize
  end

  def email
    if val = super
      val.downcase
    end
  end

  def short_name
    parts = full_name.split(' ')
    parts.first + ' ' + parts.last
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

    events.system_generated.birthday.create!(
      start_at: dob.beginning_of_day.to_s,
      name: "Happy Birthday #{short_name}",
      color: '#825a2c'
    ).create_system_occurence
    events.system_generated.work_anniversary.create!(
      start_at: doj.beginning_of_day.to_s,
      name: "Happy Work Anniversary #{short_name}",
      color: '#0077B5'
    ).create_system_occurence
  end
end
