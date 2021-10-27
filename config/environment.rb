# frozen_string_literal: true

require 'roda'
require 'yaml'

module PaperDeep
  # Configuration for the App
  class App < Roda
    CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
    API_TOKEN = CONFIG['api_key']
  end
end