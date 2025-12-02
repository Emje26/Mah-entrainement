# frozen_string_literal: true

# Item model - Represents an item in the system
class Item
  attr_accessor :id, :name, :description, :price, :quantity, :created_at, :updated_at

  @@items = []
  @@next_id = 1

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @description = attributes[:description]
    @price = attributes[:price].to_f
    @quantity = attributes[:quantity].to_i
    @created_at = attributes[:created_at] || Time.now
    @updated_at = attributes[:updated_at] || Time.now
    @errors = []
  end

  # Class methods
  class << self
    def all
      @@items.dup
    end

    def find(id)
      @@items.find { |item| item.id == id.to_i }
    end

    def find_by(attributes)
      @@items.find do |item|
        attributes.all? { |key, value| item.send(key) == value }
      end
    end

    def where(attributes)
      @@items.select do |item|
        attributes.all? { |key, value| item.send(key) == value }
      end
    end

    def create(attributes)
      item = new(attributes)
      item.save
      item
    end

    def count
      @@items.size
    end
  end

  # Instance methods
  def new_record?
    @id.nil?
  end

  def save
    return false unless valid?

    if new_record?
      @id = @@next_id
      @@next_id += 1
      @created_at = Time.now
      @@items << self
    end
    @updated_at = Time.now
    true
  end

  def update(attributes)
    attributes.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
    save
  end

  def destroy
    @@items.delete(self)
  end

  def valid?
    @errors = []
    @errors << "Name can't be blank" if name.nil? || name.empty?
    @errors << "Price must be positive" if price.nil? || price < 0
    @errors << "Quantity must be non-negative" if quantity.nil? || quantity < 0
    @errors.empty?
  end

  def errors
    @errors
  end

  def total_value
    price * quantity
  end

  def to_h
    {
      id: @id,
      name: @name,
      description: @description,
      price: @price,
      quantity: @quantity,
      created_at: @created_at,
      updated_at: @updated_at
    }
  end
end
