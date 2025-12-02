# frozen_string_literal: true

# Routes configuration - Maps URLs to controller actions

class Router
  def initialize
    @routes = { get: {}, post: {}, patch: {}, put: {}, delete: {} }
  end

  # DSL methods for defining routes
  def get(path, to:)
    @routes[:get][path] = parse_action(to)
  end

  def post(path, to:)
    @routes[:post][path] = parse_action(to)
  end

  def patch(path, to:)
    @routes[:patch][path] = parse_action(to)
  end

  def put(path, to:)
    @routes[:put][path] = parse_action(to)
  end

  def delete(path, to:)
    @routes[:delete][path] = parse_action(to)
  end

  # Resource helper - generates RESTful routes
  def resources(name, only: nil, except: nil)
    actions = %i[index show new create edit update destroy]
    actions &= Array(only) if only
    actions -= Array(except) if except

    actions.each do |action|
      case action
      when :index
        get "/#{name}", to: "#{name}#index"
      when :show
        get "/#{name}/:id", to: "#{name}#show"
      when :new
        get "/#{name}/new", to: "#{name}#new"
      when :create
        post "/#{name}", to: "#{name}#create"
      when :edit
        get "/#{name}/:id/edit", to: "#{name}#edit"
      when :update
        patch "/#{name}/:id", to: "#{name}#update"
        put "/#{name}/:id", to: "#{name}#update"
      when :destroy
        delete "/#{name}/:id", to: "#{name}#destroy"
      end
    end
  end

  # Route matching
  def match(method, path)
    method = method.downcase.to_sym
    @routes[method]&.each do |pattern, action|
      params = match_path(pattern, path)
      return [action, params] if params
    end
    nil
  end

  # Display all routes
  def display
    @routes.each do |method, paths|
      paths.each do |path, action|
        puts "#{method.to_s.upcase.ljust(8)} #{path.ljust(30)} => #{action[:controller]}##{action[:action]}"
      end
    end
  end

  private

  def parse_action(to)
    controller, action = to.split('#')
    { controller: controller, action: action }
  end

  def match_path(pattern, path)
    pattern_parts = pattern.split('/')
    path_parts = path.split('/')

    return nil if pattern_parts.size != path_parts.size

    params = {}
    pattern_parts.zip(path_parts).each do |pat, pth|
      if pat.start_with?(':')
        params[pat[1..].to_sym] = pth
      elsif pat != pth
        return nil
      end
    end
    params
  end
end

# Define application routes
ROUTES = Router.new

ROUTES.instance_eval do
  # Root
  get '/', to: 'home#index'

  # Users
  resources :users

  # Items
  resources :items
end
