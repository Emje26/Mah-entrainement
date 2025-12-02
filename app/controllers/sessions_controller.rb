# frozen_string_literal: true

# SessionsController - Handles user authentication
class SessionsController < ApplicationController
  # GET /login
  def new
    redirect_to root_path, notice: t('flash.already_logged_in') if logged_in?
  end

  # POST /login
  def create
    user = User.find_by(email: params[:email]&.downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = t('flash.login_success')
      redirect_to root_path
    else
      flash.now[:alert] = t('flash.login_failed')
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /logout
  def destroy
    session.delete(:user_id)
    @current_user = nil
    flash[:notice] = t('flash.logout_success')
    redirect_to root_path, status: :see_other
  end
end
