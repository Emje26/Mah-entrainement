# frozen_string_literal: true

# UsersController - Handles user-related actions
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy activate deactivate]
  before_action :authenticate_user!, except: %i[index show new create]

  # GET /users
  def index
    @users = User.all.order(created_at: :desc)
    @users = @users.page(params[:page]).per(10) if @users.respond_to?(:page)
  end

  # GET /users/:id
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = t('flash.actions.create.success', model: User.model_name.human)
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/:id/edit
  def edit; end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      flash[:notice] = t('flash.actions.update.success', model: User.model_name.human)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    flash[:notice] = t('flash.actions.destroy.success', model: User.model_name.human)
    redirect_to users_path, status: :see_other
  end

  # PATCH /users/:id/activate
  def activate
    @user.update(active: true)
    flash[:notice] = t('flash.user_activated')
    redirect_to @user
  end

  # PATCH /users/:id/deactivate
  def deactivate
    @user.update(active: false)
    flash[:notice] = t('flash.user_deactivated')
    redirect_to @user
  end

  # GET /users/search
  def search
    @users = User.where('name LIKE ? OR email LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%")
    render :index
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
