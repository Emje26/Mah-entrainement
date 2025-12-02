# frozen_string_literal: true

# ApplicationController - Base controller class
# All controllers inherit from this class
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Protect from CSRF attacks
  protect_from_forgery with: :exception

  # Include helpers in controllers
  include ApplicationHelper

  # Before actions
  before_action :set_locale

  # Helper methods available in views
  helper_method :current_user, :logged_in?

  protected

  # Get current user from session
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Check if user is logged in
  def logged_in?
    current_user.present?
  end

  # Require authentication for protected actions
  def authenticate_user!
    return if logged_in?

    flash[:alert] = t('flash.login_required')
    redirect_to login_path
  end

  # Require admin role
  def require_admin!
    return if current_user&.admin?

    flash[:alert] = t('flash.unauthorized')
    redirect_to root_path
  end

  # Set locale from params or default
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Include locale in URL params
  def default_url_options
    { locale: I18n.locale }
  end

  # Handle record not found
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    flash[:alert] = t('flash.record_not_found')
    redirect_to root_path
  end
end
