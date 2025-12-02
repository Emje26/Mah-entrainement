# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../models/user'

# UsersController - Handles user-related actions
class UsersController < ApplicationController
  # GET /users
  def index
    @users = User.all
    render 'users/index', locals: { users: @users }
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
    render 'users/show', locals: { user: @user }
  end

  # GET /users/new
  def new
    @user = User.new
    render 'users/new', locals: { user: @user }
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created successfully'
      redirect_to "/users/#{@user.id}"
    else
      render 'users/new', locals: { user: @user }
    end
  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
    render 'users/edit', locals: { user: @user }
  end

  # PATCH/PUT /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'User updated successfully'
      redirect_to "/users/#{@user.id}"
    else
      render 'users/edit', locals: { user: @user }
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'User deleted successfully'
    redirect_to '/users'
  end

  private

  def user_params
    params.fetch(:user, {}).slice(:name, :email, :password)
  end
end
