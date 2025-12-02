# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../models/item'

# ItemsController - Handles item-related actions
class ItemsController < ApplicationController
  # GET /items
  def index
    @items = Item.all
    render 'items/index', locals: { items: @items }
  end

  # GET /items/:id
  def show
    @item = Item.find(params[:id])
    render 'items/show', locals: { item: @item }
  end

  # GET /items/new
  def new
    @item = Item.new
    render 'items/new', locals: { item: @item }
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = 'Item created successfully'
      redirect_to "/items/#{@item.id}"
    else
      render 'items/new', locals: { item: @item }
    end
  end

  # GET /items/:id/edit
  def edit
    @item = Item.find(params[:id])
    render 'items/edit', locals: { item: @item }
  end

  # PATCH/PUT /items/:id
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = 'Item updated successfully'
      redirect_to "/items/#{@item.id}"
    else
      render 'items/edit', locals: { item: @item }
    end
  end

  # DELETE /items/:id
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:success] = 'Item deleted successfully'
    redirect_to '/items'
  end

  private

  def item_params
    params.fetch(:item, {}).slice(:name, :description, :price, :quantity)
  end
end
