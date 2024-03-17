require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WishWay
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # ジェネレータの設定を変更
    config.generators do |g|
      g.helper false             # helper ファイルを作成しない
      g.test_framework false     # test ファイルを作成しない
      g.skip_routes true         # ルーティングの記述を作成しない
    end

    # field_with_errors クラスを挿入されないようにする
    # config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    # i18n の設定
    config.i18n.default_locale = :ja
  end
end
