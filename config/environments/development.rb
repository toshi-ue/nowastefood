Rails.application.configure do
  config.after_initialize do
    Bullet.enable        = true
    Bullet.alert         = true
    Bullet.bullet_logger = true
    Bullet.console       = true
    # Bullet.growl         = true
    Bullet.rails_logger  = true
    Bullet.add_footer    = true
  end
  config.cache_classes = false
  config.reload_classes_only_on_change = false
  config.eager_load = false
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :local
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.assets.debug = true
  config.assets.quiet = true
  config.logger = Logger.new(STDOUT)
  config.log_level = :debug
  config.sass.inline_source_maps = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  # mailerの設定
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  # letter_opener_web
  config.action_mailer.delivery_method = :letter_opener_web

  config.web_console.whitelisted_ips = %w[0.0.0.0/0 127.0.0.1 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16]
  config.file_watcher = ActiveSupport::FileUpdateChecker
end
