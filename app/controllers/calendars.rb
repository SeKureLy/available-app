# frozen_string_literal: true

require 'roda'

module Available
  # Web controller for Available API
  class App < Roda
    route('calendars') do |routing|
      routing.on do
        @calendars_route = '/calendars'

        routing.is do
          # GET /calendars/
          routing.get do
              calendars_list = GetAllCalendars.new(App.config).call(@current_account)

              return {current_user: @current_account.username, calendars: calendars_list}.to_json
          end
        end

        routing.on String do |cal_id|
          routing.get do
            result = GetCalendar.new(App.config).call(@current_account, cal_id)
            calendar = Calendar.new(result)
            # puts calendar.to_json
            return {current_user: @current_account.username, calendar: calendar.to_json}.to_json
          end
        end


      end
    end
  end
end
