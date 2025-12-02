# frozen_string_literal: true

# ItemsController - Handles item-related actions
class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy publish unpublish]
  before_action :authenticate_user!, except: %i[index show featured]

  # GET /items
  def index
    @items = Item.all.order(created_at: :desc)
    @items = @items.page(params[:page]).per(12) if @items.respond_to?(:page)
  end

  # GET /items/:id
  def show; end

  # GET /items/new
  def new
    @item = Item.new
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    @item.user = current_user if current_user

    if @item.save
      flash[:notice] = t('flash.actions.create.success', model: Item.model_name.human)
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /items/:id/edit
  def edit; end

  # PATCH/PUT /items/:id
  def update
    if @item.update(item_params)
      flash[:notice] = t('flash.actions.update.success', model: Item.model_name.human)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /items/:id
  def destroy
    @item.destroy
    flash[:notice] = t('flash.actions.destroy.success', model: Item.model_name.human)
    redirect_to items_path, status: :see_other
  end

  # PATCH /items/:id/publish
  def publish
    @item.update(published: true, published_at: Time.current)
    flash[:notice] = t('flash.item_published')
    redirect_to @item
  end

  # PATCH /items/:id/unpublish
  def unpublish
    @item.update(published: false, published_at: nil)
    flash[:notice] = t('flash.item_unpublished')
    redirect_to @item
  end

  # GET /items/search
  def search
    @items = Item.where('name LIKE ? OR description LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%")
    render :index
  end

  # GET /items/featured
  def featured
    @items = Item.where(featured: true).order(created_at: :desc)
    render :index
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :quantity, :published, :featured)
  end
end
