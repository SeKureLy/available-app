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
          VerifyRegistration.new(App.config).call(account_data)
          flash[:notice] = 'Please check your email for a verification link'
          response.status = 200
          return { message: 'Please check your email for a verification link' }.to_json
        rescue VerifyRegistration::ApiServerError => e
          App.logger.warn "API server error: #{e.inspect}\n#{e.backtrace}"
          flash[:error] = 'Our servers are not responding -- please try later'
          return { message: 'Our servers are not responding -- please try later' }.to_json
        rescue StandardError => e
          App.logger.error "ERROR CREATING ACCOUNT: #{e.inspect}"
          App.logger.error e.backtrace
          response.status = 400
          return { message: 'Could not create account / Account has exist' }.to_json
        end

        # GET /auth/register/<token>
        routing.get(String) do |registration_token|
          flash.now[:notice] = 'Email Verified! Please choose a new password'
          new_account = SecureMessage.decrypt(registration_token)
          view :register_confirm,
               locals: { new_account:,
                         registration_token: }
        end
      end
    end
  end
end
