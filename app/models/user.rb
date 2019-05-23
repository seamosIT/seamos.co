# == Schema Information
#
# Table name: users
#
#  id                                        :integer          not null, primary key
#  first_surname                             :string
#  second_surname                            :string
#  names                                     :string
#  uid                                       :string
#  approved                                  :boolean
#  created_at                                :datetime         not null
#  updated_at                                :datetime         not null
#  email                                     :string
#  password_hash                             :string
#  password_salt                             :string
#  role_type                                 :integer
#  admin_photo                               :string
#  organization                              :string
#  bio                                       :string
#  birthday                                  :date
#  birthplace                                :string
#  last_election_vote_count                  :integer
#  represented_organizations                 :text
#  major_electoral_representation_localities :string
#  other_periods_elected                     :string
#  current_corporation_commission            :integer
#  proposed_initiatives_to_date              :text
#  twitter_username                          :string
#

class User < ApplicationRecord
  include ApplicationHelper
  include SimpleDiscussion::ForumUser

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable
  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  mount_uploader :admin_photo, AdminPhotoUploader

  has_many  :polls,  dependent: :destroy
  has_many  :voted_polls, source: 'poll', through: 'votes', foreign_key: 'poll_id'
  has_many  :votes, dependent: :destroy
  has_many :forum_votes, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :tags, -> { distinct }, through: :interests

  has_many :academic_titles, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :academic_titles, reject_if: proc { |attributes| attributes[:title].blank? }, allow_destroy: true

  validates  :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}, if: :admin?

  validate :email_for_admin, if: :admin?
  validate :major_electoral_representation_localities_length, if: :politician?

  validates :email, :uniqueness => {:scope => :provider}
  validates :uid, :uniqueness => {:scope => :provider}
  validates :password, confirmation: { case_sensitive: true }

  enum role_type: {ciudadano: 0, politico: 1, administrador: 2}
  enum current_corporation_commission: {"Comisión del plan": 0, "Comisión de Gobierno": 1, "Comisión de Hacienda": 2}
  enum localitie: { "Usaquén": 0,
                  "Chapinero": 1,
                  "Santa Fe": 2,
                  "San Cristóbal": 3,
                  "Usme": 4,
                  "Tunjuelito":5,
                  "Bosa": 6,
                  "Kennedy": 7,
                  "Fontibón": 8,
                  "Engativá": 9,
                  "Suba": 10,
                  "Barrios Unidos": 11,
                  "Teusaquillo": 12,
                  "Los Mártires": 13,
                  "Antonio Nariño": 14,
                  "Puente Aranda": 15,
                  "La Candelaria": 16,
                  "Rafael Uribe Uribe": 17,
                  "Ciudad Bolívar": 18,
                  "Sumapaz": 19,
                  }

  scope :by_role_type, -> (role_type) do
    self.role_types.keys.include?(role_type) ?  where(role_type: role_type) : where(role_type: nil)
  end

  scope :search, -> (search_term) {
    where("names ILIKE ? OR first_surname ILIKE ? OR second_surname ILIKE ? OR email ILIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
  }

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first
    if user
      refresh_user_image(user, auth.info.image)
      return user
    else
      where(provider: auth.provider, uid: auth.uid, email: auth.info.email).first_or_create do |user|
        refresh_user_image(user, auth.info.image)
        user.password = Devise.friendly_token[0,20]
        user.names = auth.info.name   # assuming the user model has a name
        user.provider_image = auth.info.image # assuming the user model has an image
        user.role_type = 'ciudadano'
        user.first_surname = auth.info.name.split(' ').last
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
      end
    end
  end

  def already_voted?(poll)
    !(votes.find_by(poll: poll).nil?)
  end

  def full_name
    "#{names} #{first_surname} #{second_surname}"
  end

  # for the matter of simple_discussion gem
  def name
    names
  end

  def has_polls?
    polls.present?
  end

  def vote_count
    votes.size
  end

  def resolve_admin_photo
    admin_photo.file.present? ? admin_photo.url : Rails.application.config.defaultavatar
  end

  def resolve_photo
    provider_image || Rails.application.config.defaultavatar
  end

  private

  def major_electoral_representation_localities_length
    merl = self.major_electoral_representation_localities
    if merl && merl.split(',').length > 2
      errors.add(:major_electoral_representation_localities, "Seleccione sólo dos de las localidades de mayor representación electoral")
    end
  end

  def email_for_admin
    if email.nil?
      errors.add(:email, I18n.t(:email))
    end
  end

  def politician?
    role_type == "politico"
  end

  def admin?
    role_type == "administrador"
  end

  def confirmation_required?
    # This is for avoiding confirmation process, next line maybe helps for development env
    return false
  end

  def self.refresh_user_image(user, image)
    if user.present?
      user.provider_image = image
      user.save
    end
  end
end
