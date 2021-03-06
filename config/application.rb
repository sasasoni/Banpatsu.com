require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SasaApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # ルーティングエラーの処理
    config.exceptions_app = ->(env) do
      ErrorsController.action(:show).call(env)
    end
    # config.consider_all_requests_local = false
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
