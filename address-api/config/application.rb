require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AddressApi
  class Application < Rails::Application
    config.api_only = true

    # Configure the Logger for Docker
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags = [:subdomain, :uuid]
    config.logger = ActiveSupport::TaggedLogging.new(logger)

    # prevent eager loading issues
    config.enable_dependency_loading = true

    config.autoload_paths << "#{Rails.root}/lib"
  end
end

class ProductionDBCredentializer
  def production_db_username
    credentials['username']
  end

  def production_db_password
    credentials['password']
  end

  def production_db_host
    credentials['host']
  end

  def production_db_port
    credentials['port']
  end

  def production_db
    credentials['database']
  end

  def credentials
    @credentials ||= JSON.parse(raw_credentials[:decrypted_data].gsub(/\s+/, ''))
  end

  private
  def decrypted_edek
    YAML.load_file(decrypted_edek_path)
  end

  def encrypted_sql_config
    File.open(encrypted_sql_config_path).read.chomp
  end

  def raw_credentials
    if ENV['RACK_ENV'] == 'production'
      Cryptar.decrypt(encrypted_sql_config, decrypted_edek)
    else
      {success: true, decrypted_data: "{\n \"username\": \"useruser_123\", \n \"password\": \"my_secret_password\", \n\"database\": \"my_database\", \n\"host\": \"my_host\", \n\"port\": \"my_port\"}"}
    end
  end

  def decrypted_edek_path
    '/mnt/ramdisk/unencrypted_edek_for_sql_config.yml'
  end

  def encrypted_sql_config_path
    '/mnt/ramdisk/encrypted_sql_conf.json'
  end
end
