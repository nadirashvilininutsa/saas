require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NinutsaSaas
  class Application < Rails::Application
    config.hosts << "lvh.me"

    config.hosts << /.*\.lvh\.me/


    # config.session_store :cookie_store, key: '_ninutsa_sass_session', domain: :all
    config.session_store :cookie_store, key: '_ninutsa_sass_session', domain: ["bla.lvh.me", "mamuka.lvh.me"], tld_length: 2


    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # CORS configuration - Cross-Origin Resource Sharing, is a security feature implemented by web browsers to control how resources on a web page can be requested from another domain outside the domain from which the resource originated - CORs is currently blocking routing to the subdomain and we are allowing it using the code below
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ->(origin, _env) {
          # Allow requests from any subdomain of localhost or your main domain
          origin =~ /\Ahttps?:\/\/(.*\.)?lvh.me(:\d+)?\z/ || origin =~ /\Ahttps?:\/\/(.*\.)?ninutsa-saas-app-b19faaa27c0d.herokuapp\.com\z/
        }
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true
      end
    end
  end
end
