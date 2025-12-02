# frozen_string_literal: true

# HomeController - Handles home/landing page
class HomeController < ApplicationController
  # GET /
  def index
    @recent_items = Item.order(created_at: :desc).limit(6) if defined?(Item)
    @featured_items = Item.where(featured: true).limit(3) if defined?(Item)
  end
end
