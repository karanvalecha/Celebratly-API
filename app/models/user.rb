class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :events, as: :creator

  after_save :create_anniversary_events

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

    year = Date.today.year

    events.system_generated.create(
      start_date: dob.change(year: year),
      end_date: dob.change(year: year+5),
      name: "Happy Birthday #{full_name}",
      color: '#825a2c'
    )
    events.system_generated.create(
      start_date: doj.change(year: year),
      end_date: doj.change(year: year+5),
      name: "Happy Work Anniversary #{full_name}",
      color: '#0077B5'
    )
  end
end
