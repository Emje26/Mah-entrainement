# frozen_string_literal: true

# ApplicationController - Base controller class
# All controllers inherit from this class
class ApplicationController
  attr_reader :params, :request, :response

  def initialize(params: {}, request: nil, response: nil)
    @params = params
    @request = request
    @response = response
  end

  protected

  # Render a view template
  def render(template, locals: {})
    # TODO: Implement view rendering
    puts "Rendering: #{template}"
  end

  # Redirect to another path
  def redirect_to(path)
    # TODO: Implement redirect
    puts "Redirecting to: #{path}"
  end

  # Set flash message
  def flash
    @flash ||= {}
  end

  # Get current user (if authentication is implemented)
  def current_user
    @current_user
  end

  # Check if user is authenticated
  def authenticate!
    redirect_to '/login' unless current_user
  end
end
