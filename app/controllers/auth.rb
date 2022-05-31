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

          login = Form::LoginCredentials.new.call(params)

          if login.failure?
            response.status = 401
            return {message: Form.validation_errors(login)}.to_json;
          end

          account_info = AuthenticateAccount.new(App.config).call(
            username: params['username'],
            password: params['password']
          )

          current_account = Account.new(
            account_info[:account],
            account_info[:auth_token]
          )

          CurrentSession.new(session).current_account = current_account

          flash[:notice] = "Welcome back #{account_info['username']}!"
          response.status = 200
          puts account_info
          return { account: account_info['attributes']['account']['data']['attributes']['username'], message: flash[:notice] }.to_json
          # routing.redirect '/'
        rescue AuthenticateAccount::UnauthorizedError
          # flash.now[:error] = 'Username and password did not match our records'
          response.status = 401
          return {message: 'Username and password did not match our records'}.to_json
        rescue AuthenticateAccount::ApiServerError => e
          App.logger.warn "API server error: #{e.inspect}\n#{e.backtrace}"
          flash[:error] = 'Our servers are not responding -- please try later'
          response.status = 500
          routing.redirect @login_route
        end
      end

      @logout_route = '/auth/logout'
      routing.is 'logout' do
        # GET /auth/logout
        routing.get do
          SecureSession.new(session).delete(:current_account)
          flash[:notice] = "You've been logged out"
          routing.redirect @login_route
        end
      end

      @register_route = '/auth/register'
      routing.is 'register' do
        routing.post do
          data = JSON.parse(routing.body.read)
          registration = Form::Registration.new.call(data)
          
          if registration.failure?
            flash[:error] = Form.validation_errors(registration)
            return {message: Form.validation_errors(registration)}.to_json
            # routing.redirect @register_route
          end
          
          account_data = JsonRequestBody.symbolize(data)
          VerifyRegistration.new(App.config).call(account_data)

          flash[:notice] = 'Please check your email for a verification link'
          return {message: 'Please check your email for a verification link'}.to_json
          # routing.redirect '/'
        rescue VerifyRegistration::ApiServerError => e
          App.logger.warn "API server error: #{e.inspect}\n#{e.backtrace}"
          flash[:error] = 'Our servers are not responding -- please try later'
          return {message: 'Our servers are not responding -- please try later'}.to_json
          # routing.redirect @register_route
        rescue StandardError => e
          App.logger.error "Could not verify registration: #{e.inspect}"
          flash[:error] = 'Please use English characters for username only'
          # routing.redirect @register_route
          return {message: 'Please use English characters for username only'}.to_json
        end
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
