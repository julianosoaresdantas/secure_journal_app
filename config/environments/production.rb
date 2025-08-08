# config/environments/production.rb
require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this setting.
  config.eager_load = true

  # Ensures that a master key has been made available in ENV["RAILS_MASTER_KEY"], config/master.key, or an environment
  # key file. This key is used to decrypt credentials.
  config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Compress CSS using a CSS compressor.
  # config.assets.css_compressor = "sassc"

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScript from an asset host.
  # config.asset_host = "http://assets.example.com"

  # Enable locale fallbacks for I18n (makes lookups for a translation to be
  # tried first without a locale, then with the fallback locale).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.deprecation = :silence

  # Logged in the same format as Apache LogFormat "%h %l %u %t \"%r\" %>s %b"
  config.log_formatter = ::Logger::Formatter.new

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a different logger for distributed setups.
  # require "syslog/logger"
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new "app-name")

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    config.logger.formatter = config.log_formatter
  end

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]
  config.force_ssl = true
  # The `Content-Disposition` header is set to `inline` by default.
  # This is a security risk. Please check your applications file-serving
  # mechanisms for a fix.
  # config.action_dispatch.default_headers = {
  #  'Content-Disposition' => 'inline',
  #  'X-Content-Type-Options' => 'nosniff'
  # }

  # Set a strict CSP header.
  # config.action_dispatch.default_headers = {
  #  'Content-Security-Policy' => "default-src 'self' 'unsafe-inline' 'unsafe-eval' https:; font-src 'self' https: data:; img-src 'self' https: data:; style-src 'self' 'unsafe-inline' https:; script-src 'self' 'unsafe-inline' 'unsafe-eval' https:;"
  # }

  # Use a different cache store in production.
  config.cache_store = :file_store, "tmp/cache/production"
end
