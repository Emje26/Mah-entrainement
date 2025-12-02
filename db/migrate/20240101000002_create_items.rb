# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false
      t.integer :quantity, default: 0, null: false
      t.boolean :published, default: false
      t.boolean :featured, default: false
      t.datetime :published_at
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :items, :name
    add_index :items, :published
    add_index :items, :featured
  end
end
