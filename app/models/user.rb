# frozen_string_literal: true

# User model - Represents a user in the system
class User
  attr_accessor :id, :name, :email, :password_digest, :created_at, :updated_at

  @@users = []
  @@next_id = 1

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @email = attributes[:email]
    @password_digest = attributes[:password_digest]
    @created_at = attributes[:created_at] || Time.now
    @updated_at = attributes[:updated_at] || Time.now
    @errors = []
  end

  # Class methods
  class << self
    def all
      @@users.dup
    end

    def find(id)
      @@users.find { |user| user.id == id.to_i }
    end

    def find_by(attributes)
      @@users.find do |user|
        attributes.all? { |key, value| user.send(key) == value }
      end
    end

    def create(attributes)
      user = new(attributes)
      user.save
      user
    end

    def count
      @@users.size
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
      @@users << self
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
    @@users.delete(self)
  end

  def valid?
    @errors = []
    @errors << "Name can't be blank" if name.nil? || name.empty?
    @errors << "Email can't be blank" if email.nil? || email.empty?
    @errors.empty?
  end

  def errors
    @errors
  end

  def to_h
    {
      id: @id,
      name: @name,
      email: @email,
      created_at: @created_at,
      updated_at: @updated_at
    }
  end
end
