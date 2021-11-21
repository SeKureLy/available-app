# frozen_string_literal: true

require 'figaro'
require 'roda'
require 'sequel'
require 'yaml'
require 'delegate' # needed until Rack 2.3 fixes delegateclass bug

module PaperDeep
  # Configuration for the App
  class App < Roda
    plugin :environments
    # rubocop:disable Lint/ConstantDefinitionInBlock
    configure do
      # Environment variables setup
      Figaro.application = Figaro::Application.new(
        environment: environment,
        path: File.expand_path('config/secrets.yml')
      )
      Figaro.load
      def self.config() = Figaro.env
      configure :development, :test do
        ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
      end

      use Rack::Session::Cookie, secret: config.SESSION_SECRET

      # Database Setup
      DB = Sequel.connect(ENV['DATABASE_URL'])
      # deliberately :reek:UncommunicativeMethodName calling method DB
      def self.DB() = DB # rubocop:disable Naming/MethodName
    end
    # rubocop:enable Lint/ConstantDefinitionInBlock
  end
end
