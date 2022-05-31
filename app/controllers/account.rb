# frozen_string_literal: true

require 'roda'
require_relative './app'

module Available
  # Web controller for Available API
  class App < Roda
    route('account') do |routing|
      routing.on do
        # GET /account/<username>
        routing.get String do |username|
          puts @current_account
          # puts @current_account['username']
          if @current_account && @current_account['username'] == username
            return { current_account: @current_account }.to_json
          else
            routing.redirect '/auth/login'
          end
        end

        # POST /account/<registration_token>
        routing.post String do |registration_token|
          body = JSON.parse(routing.body.read)
          raise 'Passwords do not match or empty' if
            body['password'].empty? ||
            body['password'] != body['password_confirm']

          new_account = SecureMessage.decrypt(registration_token)
          CreateAccount.new(App.config).call(
            email: new_account['email'],
            username: new_account['username'],
            password: body['password']
          )
          flash[:notice] = 'Account created! Please login'
          return {message:'Account created! Please login'}.to_json
        rescue CreateAccount::InvalidAccount => e
          flash[:error] = e.message
          return {message:flash[:error]}.to_json
        rescue StandardError => e
          flash[:error] = e.message
          routing.redirect(
            "#{App.config.APP_URL}/auth/register/#{registration_token}"
          )
        end
      end
    end
  end
end
