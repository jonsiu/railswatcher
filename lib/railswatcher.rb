# frozen_string_literal: true

require_relative "railswatcher/version"
require 'active_support/notifications'
require 'httparty'

module RailsWatcher
  class Error < StandardError; end
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    def endpoint
      @endpoint ||= ENV['RAILSWATCHER_ENDPOINT']
    end
  end

  def self.log(payload)
    endpoint = RailsWatcher.configuration.endpoint
    return unless endpoint
    HTTParty.post(endpoint,
                  body: { query: payload[:sql] }.to_json,
                  headers: { 'Content-Type' => 'application/json' })
  end

  ActiveSupport::Notifications.subscribe("sql.active_record") do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    log(event.payload)
  end
end
