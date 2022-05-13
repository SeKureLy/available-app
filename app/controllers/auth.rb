# frozen_string_literal: true

require 'roda'
require_relative './app'

module Available
  # Web controller for Available API
  class App < Roda
    route('auth') do |routing|
      @login_route = '/auth/login'
      routing.is 'login' do
        # POST /auth/login
        routing.post do
          params = JSON.parse(routing.body.read)
          account = AuthenticateAccount.new(App.config).call(
            username: params['username'],
            password: params['password']
          )

          SecureSession.new(session).set(:current_account, account)
          flash[:notice] = "Welcome back #{account['username']}!"
          response.status = 200
          return { account: account['data']['attributes']['username'], message: flash[:notice] }.to_json
        rescue StandardError
          flash[:error] = 'Username and password did not match our records'
          response.status = 400
          return { message: 'Username and password did not match our records' }.to_json
        end
      end

      routing.on 'logout' do
        routing.get do
          SecureSession.new(session).delete(:current_account)
          routing.redirect @login_route
        end
      end

      routing.is 'register' do
        routing.post do
          account_data = JsonRequestBody.symbolize(JSON.parse(routing.body.read))
          acc = CreateAccount.new(App.config).call(**account_data)
          puts acc.to_json
          response.status = 200
          return { message: 'Please login with your new account information' }.to_json
        rescue StandardError => e
          App.logger.error "ERROR CREATING ACCOUNT: #{e.inspect}"
          App.logger.error e.backtrace
          response.status = 400
          return { message: 'Could not create account / Account has exist' }.to_json
        end
      end
    end
  end
end
