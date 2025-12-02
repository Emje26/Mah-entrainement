# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Run with: bin/rails db:seed

puts 'Seeding database...'

# Create admin user
admin = User.find_or_initialize_by(email: 'admin@example.com')
if admin.new_record?
  admin.assign_attributes(
    name: 'Admin User',
    password: 'password123',
    password_confirmation: 'password123',
    admin: true
  )
  admin.save!
  puts 'Created admin user: admin@example.com'
else
  puts 'Admin user already exists, skipping...'
end

# Create sample users
users_data = [
  { name: 'Alice Martin', email: 'alice@example.com', password: 'password123' },
  { name: 'Bob Dupont', email: 'bob@example.com', password: 'password123' },
  { name: 'Charlie Durand', email: 'charlie@example.com', password: 'password123' }
]

users_data.each do |user_data|
  user = User.find_or_initialize_by(email: user_data[:email])
  if user.new_record?
    user.assign_attributes(
      name: user_data[:name],
      password: user_data[:password],
      password_confirmation: user_data[:password]
    )
    user.save!
    puts "Created user: #{user_data[:name]}"
  else
    puts "User #{user_data[:name]} already exists, skipping..."
  end
end

# Create sample items
items_data = [
  { name: 'Laptop', description: 'High-performance laptop for developers', price: 999.99, quantity: 10, published: true, featured: true },
  { name: 'Mouse', description: 'Ergonomic wireless mouse', price: 29.99, quantity: 50, published: true },
  { name: 'Keyboard', description: 'Mechanical keyboard with RGB lighting', price: 79.99, quantity: 30, published: true },
  { name: 'Monitor', description: '27-inch 4K display with HDR', price: 449.99, quantity: 15, published: true, featured: true },
  { name: 'Headphones', description: 'Noise-canceling wireless headphones', price: 199.99, quantity: 25, published: true },
  { name: 'Webcam', description: '1080p HD webcam with microphone', price: 59.99, quantity: 40, published: true },
  { name: 'USB Hub', description: '7-port USB 3.0 hub', price: 24.99, quantity: 100, published: true },
  { name: 'Laptop Stand', description: 'Adjustable aluminum laptop stand', price: 39.99, quantity: 35, published: false }
]

first_user = User.first

items_data.each do |item_data|
  item = Item.find_or_initialize_by(name: item_data[:name])
  if item.new_record?
    item.assign_attributes(item_data.merge(user: first_user))
    item.published_at = Time.current if item.published?
    item.save!
    puts "Created item: #{item_data[:name]}"
  else
    puts "Item #{item_data[:name]} already exists, skipping..."
  end
end

puts ''
puts 'Seeding completed!'
puts "Total users: #{User.count}"
puts "Total items: #{Item.count}"
puts ''
puts 'Login credentials:'
puts '  Admin: admin@example.com / password123'
puts '  User:  alice@example.com / password123'
