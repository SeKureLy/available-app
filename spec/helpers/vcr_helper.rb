# frozen_string_literal: true

require 'vcr'
require 'webmock'

# Setting up VCR
module VcrHelper
  CASSETTES_FOLDER = 'spec/fixtures/cassettes'
  CASSETTE_FILE = 'scopus_api'

  def self.setup_vcr
    VCR.configure do |config|
      config.cassette_library_dir = CASSETTES_FOLDER
      config.hook_into :webmock
    end
  end

  # Unavoidable :reek:TooManyStatements for VCR configuration
  def self.configure_vcr
    VCR.configure do |config|
      config.filter_sensitive_data('SCOPUS_API_TOKEN') { API_TOKEN }
      config.filter_sensitive_data('SCOPUS_API_TOKEN_ESC') { CGI.escape(API_TOKEN) }
    end

    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  def self.eject_vcr
    VCR.eject_cassette
  end
end