# frozen_string_literal: true

require "test_helper"
require 'active_support/notifications'
require 'httparty'

class TestRailsWatcher < Minitest::Test
  def setup
    RailsWatcher.configure do |config|
      config.endpoint = "http://localhost:3000/logs"
    end
  end

  def test_logs_and_sends_sql_queries
    expect(HTTParty).to receive(:post).with("http://localhost:3000/logs",
                                            body: { query: "SELECT * FROM users" }.to_json,
                                            headers: { 'Content-Type' => 'application/json' })

    ActiveRecord::Base.connection.execute("SELECT * FROM users")
  end

  def test_does_not_log_or_send_without_endpoint
    RailsWatcher.configure do |config|
      config.endpoint = nil
    end

    expect(HTTParty).not_to receive(:post)

    ActiveRecord::Base.connection.execute("SELECT * FROM users")
  end
end
