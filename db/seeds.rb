# frozen_string_literal: true

# Seeds file - Initial data for the database
# Run with: bin/console db:seed

puts 'Seeding database...'

# Create sample users
users_data = [
  { name: 'Alice Martin', email: 'alice@example.com' },
  { name: 'Bob Dupont', email: 'bob@example.com' },
  { name: 'Charlie Durand', email: 'charlie@example.com' }
]

users_data.each do |user_data|
  user = User.find_by(email: user_data[:email])
  if user
    puts "User #{user_data[:name]} already exists, skipping..."
  else
    User.create(user_data)
    puts "Created user: #{user_data[:name]}"
  end
end

# Create sample items
items_data = [
  { name: 'Laptop', description: 'High-performance laptop', price: 999.99, quantity: 10 },
  { name: 'Mouse', description: 'Wireless mouse', price: 29.99, quantity: 50 },
  { name: 'Keyboard', description: 'Mechanical keyboard', price: 79.99, quantity: 30 },
  { name: 'Monitor', description: '27-inch 4K display', price: 449.99, quantity: 15 },
  { name: 'Headphones', description: 'Noise-canceling headphones', price: 199.99, quantity: 25 }
]

items_data.each do |item_data|
  item = Item.find_by(name: item_data[:name])
  if item
    puts "Item #{item_data[:name]} already exists, skipping..."
  else
    Item.create(item_data)
    puts "Created item: #{item_data[:name]}"
  end
end

puts 'Seeding completed!'
puts "Total users: #{User.count}"
puts "Total items: #{Item.count}"
