# frozen_string_literal: true

require 'roda'

module Available
  # Web controller for Available API
  class App < Roda
    route('calendars') do |routing|
      routing.on do
        puts @current_account.logged_in?
        routing.redirect '/auth/login' unless @current_account.logged_in?
        @calendars_route = '/calendars'


        # GET /calendars/
        routing.get do
            calendars_list = GetAllCalendars.new(App.config).call(@current_account)
            calendars = Calendars.new(calendars_list)

            return {current_user: @current_account, calendars: calendars}.to_json
        end
      end
    end
  end
end
