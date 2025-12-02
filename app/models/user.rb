# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  admin           :boolean          default(FALSE)
#  active          :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  # Secure password with bcrypt
  has_secure_password

  # Associations
  has_many :items, dependent: :nullify

  # Validations
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || password.present? }

  # Callbacks
  before_save :downcase_email

  # Scopes
  scope :active, -> { where(active: true) }
  scope :admins, -> { where(admin: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :search, ->(query) { where('name LIKE ? OR email LIKE ?', "%#{query}%", "%#{query}%") }

  # Instance methods
  def admin?
    admin == true
  end

  def activate!
    update(active: true)
  end

  def deactivate!
    update(active: false)
  end

  def full_name
    name
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
