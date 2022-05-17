# frozen_string_literal: true

require 'roda'

module Available
  # Web controller for Available API
  class App < Roda
    route('calendars') do |routing|
      routing.on do
        # GET /calendars/
        routing.get do
          if @current_account.logged_in?
            calendars_list = GetAllCalendars.new(App.config).call(@current_account)

            calendars = Calendars.new(calendars_list)

            view :calendars_all,
                 locals: { current_user: @current_account, calendars: }
          else
            routing.redirect '/auth/login'
          end
        end
      end
    end
  end
end
