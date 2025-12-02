# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  description  :text
#  price        :decimal(10, 2)   default(0.0), not null
#  quantity     :integer          default(0), not null
#  published    :boolean          default(FALSE)
#  featured     :boolean          default(FALSE)
#  published_at :datetime
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Item < ApplicationRecord
  # Associations
  belongs_to :user, optional: true

  # Validations
  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Scopes
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :featured, -> { where(featured: true) }
  scope :in_stock, -> { where('quantity > 0') }
  scope :out_of_stock, -> { where(quantity: 0) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_price, ->(direction = :asc) { order(price: direction) }
  scope :search, ->(query) { where('name LIKE ? OR description LIKE ?', "%#{query}%", "%#{query}%") }

  # Callbacks
  before_save :set_published_at

  # Instance methods
  def publish!
    update(published: true, published_at: Time.current)
  end

  def unpublish!
    update(published: false, published_at: nil)
  end

  def in_stock?
    quantity.positive?
  end

  def out_of_stock?
    quantity.zero?
  end

  def total_value
    price * quantity
  end

  def formatted_price
    ActionController::Base.helpers.number_to_currency(price, unit: '€', format: '%n %u')
  end

  private

  def set_published_at
    self.published_at = Time.current if published_changed? && published?
    self.published_at = nil if published_changed? && !published?
  end
end
