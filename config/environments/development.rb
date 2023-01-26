Rails.application.configure do
  config.after_initialize do
    Bullet.enable        = true
    Bullet.alert         = true
    Bullet.bullet_logger = true
    Bullet.console       = true
    Bullet.rails_logger  = true
    Bullet.add_footer    = true
  end
  config.cache_classes = false
  config.reload_classes_only_on_change = false
  config.eager_load = false
  config.consider_all_requests_local = true
  # config.consider_all_requests_local = false

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

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true
  # Debug mode disables concatenation and preprocessing of assets.
	# This option may cause significant delays in view rendering with a large
	# number of complex assets.
  config.assets.debug = true
  # Suppress logger output for asset requests.
  config.assets.quiet = true
  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true
  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true
  config.sass.inline_source_maps = true
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :letter_opener_web

  config.web_console.allowed_ips = %w[0.0.0.0/0 127.0.0.1 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16]
  config.file_watcher = ActiveSupport::FileUpdateChecker

  # Uncomment if you wish to allow Action Cable access from any origin.
	# config.action_cable.disable_request_forgery_protection = true
end
