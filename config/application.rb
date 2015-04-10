require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Timetracker
  class Application < Rails::Application
    config.sass.preferred_syntax = :sass
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %W(#{config.root}/app/models/records)
  end
end
