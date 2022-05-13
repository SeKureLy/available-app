# frozen_string_literal: true

require 'roda'
require 'rack/cors'
require 'json'

module Available
  # Web App
  class App < Roda
    use Rack::Cors, debug: true, logger: Logger.new($stdout) do
      allowed_methods = %i[get post put delete options head]
      allow do
        origins 'localhost:3001'
        resource '*', headers: :any, methods: allowed_methods, credentials: true
      end
    end
    plugin :public, root: 'app/presentation/built', gzip: true
    plugin :halt
    plugin :multi_route
    plugin :flash

    ONE_MONTH = 30 * 24 * 60 * 60

    use Rack::Session::Cookie,
        expire_after: ONE_MONTH,
        secret: config.SESSION_SECRET

    route do |routing|
      response['Content-Type'] = 'text/html; charset=utf-8'
      @current_account = SecureSession.new(session).get(:current_account)

      routing.public

      # GET /
      routing.root do
        File.read('app/presentation/built/index.html')
      end

      routing.on ['login', 'register'] do
        File.read('app/presentation/built/index.html')
      end

      routing.on 'api/v1' do
        routing.multi_route
      end
    end
  end
end
