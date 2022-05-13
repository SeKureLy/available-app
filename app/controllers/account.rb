# frozen_string_literal: true

require 'roda'
require_relative './app'

module Available
  # Web controller for Available API
  class App < Roda
    route('account') do |routing|
      routing.on do
        # GET /account/login
        routing.get String do |username|
          if @current_account && @current_account['username'] == username
            return { current_account: @current_account }.to_json
          else
            routing.redirect '/login'
          end
        end
      end
    end
  end
end
