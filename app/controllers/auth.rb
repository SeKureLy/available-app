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

          account_info = AuthenticateAccount.new(App.config).call(
            username: params['username'],
            password: params['password']
          )

          @current_account = Account.new(
            account_info[:account],
            account_info[:auth_token]
          )

          # @current_account = CurrentSession.new(session).set(:current_account, account_info)
          # session[:current_account] = account_info
          CurrentSession.new(session).current_account = current_account

          # puts CurrentSession.new(session).current_account.username

          flash[:notice] = "Welcome back #{account_info[:account]['username']}!"
          response.status = 200
          return { account: account_info[:account], auth_token: account_info[:auth_token], message: flash[:notice] }.to_json
          # routing.redirect '/'
        rescue AuthenticateAccount::UnauthorizedError
          # flash.now[:error] = 'Username and password did not match our records'
          response.status = 401
          return {message: 'Username and password did not match our records'}.to_json
        rescue AuthenticateAccount::ApiServerError => e
          App.logger.warn "API server error: #{e.inspect}\n#{e.backtrace}"
          flash[:error] = 'Our servers are not responding -- please try later'
          response.status = 500
          # routing.redirect @login_route
        end
      end

      @logout_route = '/auth/logout'
      routing.is 'logout' do
        # GET /auth/logout
        routing.get do
          SecureSession.new(session).delete(:current_account)
          flash[:notice] = "You've been logged out"
          # routing.redirect @login_route
          return { message: flash[:notice] }.to_json
        end
      end

      @register_route = '/auth/register'
      routing.is 'register' do
        # POST /auth/register
        routing.post do
          account_data = JsonRequestBody.symbolize(JSON.parse(routing.body.read))
          VerifyRegistration.new(App.config).call(account_data)

          flash[:notice] = 'Please check your email for a verification link'
          # routing.redirect '/'
          return {message: 'Please check your email for a verification link'}.to_json
        rescue VerifyRegistration::ApiServerError => e
          App.logger.warn "API server error: #{e.inspect}\n#{e.backtrace}"
          flash[:error] = 'Our servers are not responding -- please try later'
          # routing.redirect @register_route
          return {message: 'Our servers are not responding -- please try later'}.to_json
        rescue StandardError => e
          App.logger.error "Could not verify registration: #{e.inspect}"
          flash[:error] = 'Registration details are not valid'
          # routing.redirect @register_route
          return {message: 'Registration details are not valid'}.to_json
        end
      end

      # GET /auth/register/<token>
      routing.get(String) do |registration_token|
        flash.now[:notice] = 'Email Verified! Please choose a new password'
        new_account = SecureMessage.decrypt(registration_token)
        # view :register_confirm,
        #      locals: { new_account:,
        #                registration_token: }
    end
    end
  end
end
