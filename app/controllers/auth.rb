# frozen_string_literal: true

require 'roda'
require_relative './app'

module Available
  # Web controller for Credence API
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

          session[:current_account] = account
          flash[:notice] = "Welcome back #{account['username']}!"
          response.status = 200
          return {account: account['username'],message: flash[:notice]}.to_json
        rescue StandardError
          flash[:error] = 'Username and password did not match our records'
          response.status = 400
          return {message: flash[:error]}.to_json
        end
      end

      routing.on 'logout' do
        routing.get do
          session[:current_account] = nil
          routing.redirect @login_route
        end
      end
    end
  end
end
